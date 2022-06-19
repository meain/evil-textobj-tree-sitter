;;; evil-textobj-tree-sitter-test.el --- Tests for evil-textobj-tree-sitter -*- lexical-binding: t -*-

;;; Commentary:
;; We can only use statically linked files here or libstdc++ screams at you.
;; C is an ideal candidate for this as it is builtin and is statically linked.

(require 'tree-sitter-langs)
(require 'evil-textobj-tree-sitter)

(ert-deftest evil-textobj-tree-sitter-within-unicode-test
    ()
  "Simple check with point inside the calling thigy and no unicode chars."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Łukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 28 43))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test-outer
    ()
  "Simple check with point inside the calling thigy and no unicode chars."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Łukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.outer"))) (cons 11 45))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-unicode-test2
    ()
  "Simple check with point inside the calling thigy and no unicode chars."
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
  "Simple check with point inside the calling thigy and no unicode chars."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".go"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (setq major-mode 'go-mode)
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

(ert-deftest evil-textobj-tree-sitter-within-unicode-test4
    ()
  "Check sorting of nested object in multibyte file."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Комментарий Комментарий Комментарий Комментарий Комментарий
int main() {
    if (1) if (0) { true; }
}")
      (tree-sitter-mode)
      (goto-char 100)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "conditional.outer"))) (cons 88 104))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-within-test
    ()
  "Simple check with point inside the calling thigy with unicode chars."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 28 43))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-lookahed-test
    ()
  "Check with lookahed."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 28 43))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-right-at-start-test
    ()
  "Checking for off by one errors at start."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Lukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 10)
      (should (equal (evil-textobj-tree-sitter--range 1
                                                      (list (intern "function.inner"))) (cons 28 43))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textoj-tree-sitter-check-query-read-simple
    ()
  "Simple query read check."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p ";; \"Classes\""
                             (evil-textobj-tree-sitter--get-query "zig"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nocomment
    ()
  "Check a query file with no comment."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "(function_definition"
                             (evil-textobj-tree-sitter--get-query "bash"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested
    ()
  "Check a query with nested files to be loaded."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (jsx)"
                             (evil-textobj-tree-sitter--get-query "typescript"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-nofile
    ()
  "Check a file pointing to a non existent file."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (jsx)"
                             (evil-textobj-tree-sitter--get-query "javascript"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-nested-multi
    ()
  "Check a query with multiple nesting items."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (javascript)"
                             (evil-textobj-tree-sitter--get-query "tsx"
                                                                  t)))))

(ert-deftest evil-textoj-tree-sitter-check-query-read-non-top-level
    ()
  "Check a non top level direct query."
  (let ((evil-textobj-tree-sitter--queries-dir "fixtures/"))
    (should (string-prefix-p "; inherits: (javascript)"
                             (evil-textobj-tree-sitter--get-query "typescript"
                                                                  nil)))))


(ert-deftest evil-textobj-tree-sitter-goto-next-start-simple
    ()
  "Go to next start simple test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  nil
                                                                  nil
                                                                  nil) 10)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-next-start-simple2
    ()
  "Go to next start simple test.  This is to check if sorting is working."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
func main(arg1, arg2) {
	another_func(arg1)
}")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "parameter.outer"))
                                                                  nil
                                                                  nil
                                                                  nil) 20)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-next-start-unicode
    ()
  "Go to next start with unicode in comment."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// Łukasz
int main() {
    printf(\"hello\")
}")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  nil
                                                                  nil
                                                                  nil) 11)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-next-end-simple
    ()
  "Go to next start simple test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}
")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  nil
                                                                  t
                                                                  nil) 43)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-goto-next-end-multi
    ()
  "Go to next start simple test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}
")
      (tree-sitter-mode)
      (goto-char 46)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  nil
                                                                  t
                                                                  nil) 81)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-previous-end-multi
    ()
  "Go to next start simple test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}

int main3() {
    printf(\"hello3\")
}
")
      (tree-sitter-mode)
      (goto-char 83)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  t
                                                                  t
                                                                  nil) 81)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-previous-end-multi-on-end
    ()
  "Testing going to end of previous one while on end of current one."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}

int main3() {
    printf(\"hello3\")
}
")
      (tree-sitter-mode)
      (goto-char 82)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  t
                                                                  t
                                                                  nil) 43)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-goto-previous-end-multi-on-end-with-comment-at-end
    ()
  "Testing going to end of previous one while on end of current one."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
} // one

int main2() {
    printf(\"hello2\")
} // two

int main3() {
    printf(\"hello3\")
} // three
")
      (tree-sitter-mode)
      (goto-char 82)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  t
                                                                  t
                                                                  nil) 43)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-goto-next-end-multi-on-end
    ()
  "Testing going to end of previous one while on end of current one."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}

int main3() {
    printf(\"hello3\")
}
")
      (tree-sitter-mode)
      ;; somehow (goto-char 44) (point) gives 43?
      (goto-char 43)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  nil
                                                                  t
                                                                  nil) 81)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-goto-previous-start-multi-on-start
    ()
  "Testing going to start of previous one while on start of current one."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".c"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "// mango
int main() {
    printf(\"hello\")
}

int main2() {
    printf(\"hello2\")
}

int main3() {
    printf(\"hello3\")
}
")
      (tree-sitter-mode)
      (goto-char 46)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  t
                                                                  nil
                                                                  nil) 10)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-tree-sitter-goto-previous-start-nested
    ()
  "Go to next start simple test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".go"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (setq major-mode 'go-mode)
      (insert "// comment
func main() {
	fmt.Println(\"howdy bruh!\")
	func() {
		fmt.Println(\"yo!\")
	}
}")
      (tree-sitter-mode)
      (goto-char 66)
      (should (equal (evil-textobj-tree-sitter--get-goto-location (mapcar #'intern
                                                                          (list "function.outer"))
                                                                  t
                                                                  nil
                                                                  nil) 55)))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-previous-start-nested-2
    ()
  "Go to previous nested function test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (setq python-indent-guess-indent-offset nil
          python-indent-offset 4)
    (find-file filename)
    (with-current-buffer bufname
      (setq major-mode 'python-mode)
      (insert "def func ():
    var1
    def nested():
        var2
    var3
")
      (tree-sitter-mode)
      ;; place the cursor after the nested function (on var3)
      (goto-char 58)
      (let ((pos (evil-textobj-tree-sitter--get-goto-location
                  (mapcar #'intern (list "function.outer")) t nil nil)))
        ;; cursor should be on the beginning of nested function after move to the previous outer function
        (should (equal pos 27))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-previous-start-nested-3
    ()
  "Go to previous nested complex test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (setq python-indent-guess-indent-offset nil
          python-indent-offset 4)
    (find-file filename)
    (with-current-buffer bufname
      (setq major-mode 'python-mode)
      (insert "def func ():
    var1
    def func2(): pass
    def nested():
        var2
        def inner():
            var3
        var4
    var5
")
      (tree-sitter-mode)
      ;; place the cursor on var2 (inside two nested functions)
      (goto-char 71)
      (let ((pos (evil-textobj-tree-sitter--get-goto-location
                  (mapcar #'intern (list "function.outer")) t nil nil)))
        ;; cursor should be on the beginning of nested
        (should (equal pos 49))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-tree-sitter-goto-next-end-nested-2
    ()
  "Go to next nested function test."
  (let* ((bufname (concat (make-temp-name "evil-textobj-tree-sitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (setq python-indent-guess-indent-offset nil
          python-indent-offset 4)
    (find-file filename)
    (with-current-buffer bufname
      (setq major-mode 'python-mode)

      (insert "def func ():
    var1
    def nested():
        var2
    var3
")
      (tree-sitter-mode)
      ;; place the cursor before the nested function (on var1)
      (goto-char 18)
      (let ((pos (evil-textobj-tree-sitter--get-goto-location
                  (mapcar #'intern (list "function.outer")) nil t nil)))
      ;; cursor should be on the end of nested function (var2)
        (should (equal pos 52))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

;;; evil-textobj-tree-sitter-test.el ends here
