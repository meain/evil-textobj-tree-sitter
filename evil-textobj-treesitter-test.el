;;; evil-textobj-treesitter-test.el --- Tests for evil-textobj-treesitter -*- lexical-binding: t -*-

(require 'tree-sitter-langs)
(require 'evil-textobj-treesitter)

(ert-deftest evil-textobj-treesitter-zero-test
    ()
  "Zero check blank test."
  (should (equal 0 0)))

(ert-deftest evil-textobj-treesitter-within-unicode-test
    ()
  "Simple check with point inside the calling thigy and no unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-treesitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Łukasz
def test():
    print('hello')")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-treesitter--range 1
                                                     (list (intern "function.inner"))) (cons 26 40))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-treesitter-within-test
    ()
  "Simple check with point inside the calling thigy with unicode chars"
  (let* ((bufname (concat (make-temp-name "evil-textobj-treesitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
def test():
    print('hello')")
      (tree-sitter-mode)
      (goto-char 31)
      (should (equal (evil-textobj-treesitter--range 1
                                                     (list (intern "function.inner"))) (cons 26 40))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


(ert-deftest evil-textobj-treesitter-lookahed-test
    ()
  "Check with lookahed"
  (let* ((bufname (concat (make-temp-name "evil-textobj-treesitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
def test():
    print('hello')")
      (tree-sitter-mode)
      (goto-char 1)
      (should (equal (evil-textobj-treesitter--range 1
                                                     (list (intern "function.inner"))) (cons 26 40))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

(ert-deftest evil-textobj-treesitter-right-at-start-test
    ()
  "Checking for off by one errors at start"
  (let* ((bufname (concat (make-temp-name "evil-textobj-treesitter-test--")
                          ".py"))
         (filename (concat "/tmp/" bufname)))
    (find-file filename)
    (with-current-buffer bufname
      (insert "# Lukasz
def test():
    print('hello')")
      (tree-sitter-mode)
      (goto-char 10)
      (should (equal (evil-textobj-treesitter--range 1
                                                     (list (intern "function.outer"))) (cons 10 40))))
    (set-buffer-modified-p nil)
    (kill-buffer bufname)))

;;; evil-textobj-treesitter-test.el ends here
