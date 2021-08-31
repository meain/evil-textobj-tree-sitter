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

;;; evil-textobj-tree-sitter-test.el ends here
