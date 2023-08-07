;;; evil-textobj-tree-sitter-test.el --- Tests for evil-textobj-tree-sitter -*- lexical-binding: t -*-

;;; Commentary:
;; We can only use statically linked files here or libstdc++ screams at you.
;; C is an ideal candidate for this as it is builtin and is statically linked.

;;; Code:

(require 'tree-sitter-langs)
(require 'evil-textobj-tree-sitter)
(require 'go-mode)

(setq treesit-language-source-alist
      '((c . ("https://github.com/tree-sitter/tree-sitter-c"))
        (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
        (python . ("https://github.com/tree-sitter/tree-sitter-python"))
        (go . ("https://github.com/tree-sitter/tree-sitter-go"))
        (gomod . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))))

(treesit-install-language-grammar 'c)
(treesit-install-language-grammar 'cpp)
(treesit-install-language-grammar 'python)
(treesit-install-language-grammar 'go)
(treesit-install-language-grammar 'gomod)

(defvar evil-textobj-tree-sitter--test-file-content
  '((c-simple . "// Lukasz
int main() {
    printf(\"hello\")
}")
    (c-multiple-funcs .  "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}
")
    (c-unicode . "// Łukasz
int main() {
    printf(\"hello\")
}")
    (c-multibyte . "// Комментарий
int main(int temp, int temp2) {
    printf(\"hello\");
}")
    (go-multibyte-code . "// Комментарий
func main(int Комментарий, int temp2) {
    printf(\"hello\");
}")
    (go-nested . "// comment
func main() {
	fmt.Println(\"howdy bruh!\")
	func() {
		fmt.Println(\"yo!\")
	}
}")
    (py-complex . "def func ():
    var1
    def func2(): pass
    def nested():
        var2
        def inner():
            var3
        var4
    var5
")))


(defun evil-textobj-tree-sitter--range-test (mode treesit start textobj range content)
  "Check ranges of tree-sitter targets.

`MODE' is the `major-mode' to be used.
`TREESIT' non nil will use `treesit'.
`CONTENT' is the content to be used.
`START' is the starting position.
`TEXTOBJ' is the textobject to check.
`RANGE' is the range that should be returned."
  (let* ((bufname (make-temp-name "evil-textobj-tree-sitter-test--"))
         (buffer (get-buffer-create bufname)))
    (with-current-buffer buffer
      (insert (alist-get content evil-textobj-tree-sitter--test-file-content))
      (funcall mode)
      (if (not treesit) (tree-sitter-mode))
      (message "%s" major-mode)
      (goto-char start)
      (should (equal
               (evil-textobj-tree-sitter--range 1 (list (intern textobj)))
               range)))
    (kill-buffer buffer)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test ()
  "Check inner range queries within unicode buffers."
  ;; function.inner selects brackets in treesit queries but not in tree-sitter ones
  (evil-textobj-tree-sitter--range-test 'c-mode nil 31 "function.inner" (cons 28 43) 'c-unicode)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 31 "function.inner" (cons 22 45) 'c-unicode))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test-outer ()
  "Check outer range queries within unicode buffers."
  (evil-textobj-tree-sitter--range-test 'c-mode nil 31 "function.outer" (cons 11 45) 'c-unicode)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 31 "function.outer" (cons 11 45) 'c-unicode))

(ert-deftest evil-textobj-tree-sitter-within-multibyte-buffers ()
  "Check range in multibyte comment before."
  (evil-textobj-tree-sitter--range-test 'c-mode nil 35 "parameter.inner" (cons 35 44) 'c-multibyte)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 35 "parameter.inner" (cons 35 44) 'c-multibyte))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test3 ()
  "Check range with multibyte code."
  (evil-textobj-tree-sitter--range-test 'go-mode nil 31 "parameter.inner" (cons 26 41) 'go-multibyte-code)
  (evil-textobj-tree-sitter--range-test 'go-ts-mode t 31 "parameter.inner" (cons 26 41) 'go-multibyte-code))

(ert-deftest evil-textobj-tree-sitter-within-test ()
  "Check range when we are within the textobj with buffer having only ASCII chars."
  (evil-textobj-tree-sitter--range-test 'c-mode nil 31 "function.outer" (cons 11 45) 'c-simple)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 31 "function.outer" (cons 11 45) 'c-simple))

(ert-deftest evil-textobj-tree-sitter-lookahed-test ()
  "Check range when we are before the textobj with buffer having only ASCII chars."
  (evil-textobj-tree-sitter--range-test 'c-mode nil 1 "function.outer" (cons 11 45) 'c-simple)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 1 "function.outer" (cons 11 45) 'c-simple))

(ert-deftest evil-textobj-tree-sitter-right-at-start-test ()
  "Checking for off by one errors at start."
  (evil-textobj-tree-sitter--range-test 'c-mode nil 11 "function.outer" (cons 11 45) 'c-simple)
  (evil-textobj-tree-sitter--range-test 'c-ts-mode t 11 "function.outer" (cons 11 45) 'c-simple))


;;; Reading query files

(ert-deftest evil-textoj-tree-sitter-check-query-read-simple ()
  "Simple query read check."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p ";; \"Classes\"" (evil-textobj-tree-sitter--get-query "zig" t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nocomment ()
  "Check a query file with no comment."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p "(function_definition" (evil-textobj-tree-sitter--get-query "bash" t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested ()
  "Check a query with nested files to be loaded."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p "; inherits: (jsx)" (evil-textobj-tree-sitter--get-query "typescript" t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-nofile ()
  "Check a file pointing to a non existent file."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p "; inherits: (jsx)" (evil-textobj-tree-sitter--get-query "javascript" t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-multi ()
  "Check a query with multiple nesting items."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p "; inherits: (javascript)" (evil-textobj-tree-sitter--get-query "tsx" t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-non-top-level ()
  "Check a non top level direct query."
  (let ((evil-textobj-tree-sitter--get-queries-dir-func (lambda () "fixtures/")))
    (should (string-prefix-p "; inherits: (javascript)" (evil-textobj-tree-sitter--get-query "typescript" nil)))))

(defun evil-textobj-tree-sitter--goto-test (mode treesit start textobj pos prev end content)
  "Check for location of goto actions.

`MODE' is the `major-mode' to be used.
`TREESIT' non nil will use `treesit'.
`CONTENT' is the content to be used.
`START' is the starting position.
`TEXTOBJ' is the textobject to check.
`PREV' goes to previous textobj.
`END' goes to end of textobj.
`POS' is the position that should be returned."
  (let* ((bufname (make-temp-name "evil-textobj-tree-sitter-test--"))
         (buffer (get-buffer-create bufname)))
    (with-current-buffer buffer
      (insert (alist-get content evil-textobj-tree-sitter--test-file-content))
      (funcall mode)
      (if (not treesit) (tree-sitter-mode))
      (goto-char start)
      (should (equal (evil-textobj-tree-sitter--get-goto-location
                      (list (intern textobj)) prev end nil)
                     pos)))
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-next-start-simple ()
  "Go to next start in ASCII buffers."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 1 "function.outer" 11 nil nil 'c-simple)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 1 "function.outer" 11 nil nil 'c-simple))

(ert-deftest evil-textobj-tree-sitter-goto-next-start-multiple-textobjects ()
  "Check to see if we are able to find first one when we have multiple textobjects."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 1 "parameter.outer" 25 nil nil 'c-multibyte)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 1 "parameter.outer" 25 nil nil 'c-multibyte))

(ert-deftest evil-textobj-tree-sitter-goto-next-end-simple ()
  "Check if we can navigate to end of a textobj."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 1 "function.outer" 69 nil t 'c-multibyte)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 1 "function.outer" 69 nil t 'c-multibyte))

(ert-deftest evil-textobj-tree-sitter-goto-next-end-multi ()
  "Goto end when we have multiple functions."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 1 "function.outer" 43 nil t 'c-multiple-funcs)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 1 "function.outer" 43 nil t 'c-multiple-funcs))

(ert-deftest evil-textobj-tree-sitter-goto-previous-end-multi ()
  "Goto end of previous textobj."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 69 "function.outer" 43 t t 'c-multiple-funcs)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 69 "function.outer" 43 t t 'c-multiple-funcs))

(ert-deftest evil-textobj-tree-sitter-goto-previous-end-multi-on-end ()
  "Testing going to end of previous one while on end of current one."
  (evil-textobj-tree-sitter--goto-test 'c-mode nil 82 "function.outer" 43 t t 'c-multiple-funcs)
  (evil-textobj-tree-sitter--goto-test 'c-ts-mode t 82 "function.outer" 43 t t 'c-multiple-funcs))

(ert-deftest evil-textobj-tree-sitter-goto-previous-start-nested ()
  "Goto the start of the previous textobj in a nested scenario."
  (evil-textobj-tree-sitter--goto-test 'go-mode nil 66 "function.outer" 55 t nil 'go-nested)
  (evil-textobj-tree-sitter--goto-test 'go-ts-mode t 66 "function.outer" 55 t nil 'go-nested))

(ert-deftest evil-textobj-tree-sitter-goto-previous-start-nested-3 ()
  "Go to previous nested complex test."
  (evil-textobj-tree-sitter--goto-test 'python-mode nil 71 "function.outer" 49 t nil 'py-complex)
  (evil-textobj-tree-sitter--goto-test 'python-ts-mode t 71 "function.outer" 49 t nil 'py-complex))

;;; `thing-at-point' tests

(defun evil-textobj-tree-sitter--thing-at-point-test (mode treesit start thing content selection range)
  "Check ranges of tree-sitter targets.

`MODE' is the `major-mode' to be used.
`TREESIT' non nil will use `treesit'.
`CONTENT' is the content to be used.
`START' is the starting position.
`THING' is the thing to select.
`SELECTION' is the selection that `thing-at-point' will return."
  (let* ((bufname (make-temp-name "evil-textobj-tree-sitter-test--"))
         (buffer (get-buffer-create bufname)))
    (with-current-buffer buffer
      (insert (alist-get content evil-textobj-tree-sitter--test-file-content))
      (funcall mode)
      (if (not treesit) (tree-sitter-mode))
      (goto-char start)
      (should (equal (thing-at-point thing t) selection))
      (should (equal (bounds-of-thing-at-point thing) range)))
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-thing-at-point ()
  "Check if `thing-at-point' returns correct result."
  (let ((selection "int main() {
    printf(\"hello\")
}"))
    (evil-textobj-tree-sitter--thing-at-point-test 'c-mode nil 31 'function 'c-unicode selection (cons 11 45))
    (evil-textobj-tree-sitter--thing-at-point-test 'c-ts-mode t 31 'function 'c-unicode selection (cons 11 45))))

;;; evil-textobj-tree-sitter-test.el ends here