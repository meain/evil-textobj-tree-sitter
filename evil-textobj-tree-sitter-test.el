;;; evil-textobj-tree-sitter-test.el --- Tests for evil-textobj-tree-sitter -*- lexical-binding: t -*-

;;; Commentary:
;; We can only use statically linked files here or libstdc++ screams at you.
;; C is an ideal candidate for this as it is builtin and is statically linked.

(require 'tree-sitter-langs)
(require 'evil-textobj-tree-sitter)

(ert-deftest evil-textobj-tree-sitter-zero-test
    ()
  "Zero check blank test."
  (should (equal 0 0)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test
    ()
  "Simple check with point inside the calling thigy and no unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Łukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 21 44))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test2
    ()
  "Simple check with point inside the calling thigy and no unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Комментарий
int main(int temp, int temp2) {
    printf(\"hello\");
}")
      (tree-sitter-mode)
      (goto-char 35)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "parameter.inner"))) (cons 35 44))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test3
    ()
  "Simple check with point inside the calling thigy and no unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".go"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Комментарий
func main(int Комментарий, int temp2) {
    printf(\"hello\");
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "parameter.inner"))) (cons 26 41))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-test
    ()
  "Simple check with point inside the calling thigy with unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 21 44))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-lookahed-test
    ()
  "Check with lookahed"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 21 44))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-right-at-start-test
    ()
  "Checking for off by one errors at start"
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 10)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 21 44))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textoj-tree-sitter-check-query-read-simple
    ()
  "Simple query read check"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p ";; \"Classes\""
                             (evil-textobj-tree-sitter--get-query "zig"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nocomment
    ()
  "Check a query file with no comment"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "(function_definition"
                             (evil-textobj-tree-sitter--get-query "bash"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested
    ()
  "Check a query with nested files to be loaded"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (jsx)"
                             (evil-textobj-tree-sitter--get-query "typescript"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-nofile
    ()
  "Check a file pointing to a non existent file"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (jsx)"
                             (evil-textobj-tree-sitter--get-query "javascript"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-multi
    ()
  "Check a query with multiple nesting items"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (javascript)"
                             (evil-textobj-tree-sitter--get-query "tsx"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-non-top-level
    ()
  "Check a non top level direct query"
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (javascript)"
                             (evil-textobj-tree-sitter--get-query "typescript"
                                                                  nil)))))

;;; evil-textobj-tree-sitter-test.el ends here
