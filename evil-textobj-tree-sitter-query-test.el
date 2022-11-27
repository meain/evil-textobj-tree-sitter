;;; Code:

(require 'tree-sitter-langs)
(require 'evil-textobj-tree-sitter)

(defun evil-textobj-tree-sitter--test-loading-with-comment-prefix (lang comment-prefix)
  "Try loading grammar for `LANG' and test with comment using `COMMENT-PREFIX'."
  (evil-textobj-tree-sitter--test-loading-with-comment
   lang
   (concat comment-prefix " howdy!")))

(defun evil-textobj-tree-sitter--test-loading-with-comment (lang text &optional region)
  "Try loading grammar for `LANG' and test with comment provided in `TEXT' optionally passing in `REGION'."
  (let* ((bufname (make-temp-name "evil-textobj-tree-sitter-test--"))
         (filename (concat "/tmp/" bufname)))

    (find-file filename)
    (fundamental-mode)
    (with-current-buffer bufname
      (setq-local tree-sitter-major-mode-language-alist `((fundamental-mode . ,lang)))
      (setq-local evil-textobj-tree-sitter-major-mode-language-alist `((fundamental-mode . ,(symbol-name lang))))
      (insert text)
      (tree-sitter-mode)
      (goto-char 0)
      (should (equal
               (evil-textobj-tree-sitter--range
                1
                (list (intern "comment.outer")))
               (if region region (cons 1 (+ 1 (length text)))))))

    (set-buffer-modified-p nil)
    (kill-buffer bufname)))


;; TODO: Simplify code using macros and dolist

;; bash
(ert-deftest evil-textobj-tree-sitter-try-bash ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'bash "#"))

;; c
(ert-deftest evil-textobj-tree-sitter-try-c ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'c "//"))

;; cpp
(ert-deftest evil-textobj-tree-sitter-try-cpp ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'cpp "//"))

;; elixir
(ert-deftest evil-textobj-tree-sitter-try-elixir ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'elixir "#"))

;; elm
(ert-deftest evil-textobj-tree-sitter-try-elm ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'elm "--"))

;; go
(ert-deftest evil-textobj-tree-sitter-try-go ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'go "//"))

;; haskell
(ert-deftest evil-textobj-tree-sitter-try-haskell ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'haskell "--"))

;; hcl
(ert-deftest evil-textobj-tree-sitter-try-hcl ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'hcl "#"))

;; html <!--
(ert-deftest evil-textobj-tree-sitter-try-html ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'html "<!-- howdy -->"))

;; java
(ert-deftest evil-textobj-tree-sitter-try-java ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'java "//"))

;; javascript
(ert-deftest evil-textobj-tree-sitter-try-javascript ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'javascript "//"))

;; julia TODO: Needs grammar update
;; (ert-deftest evil-textobj-tree-sitter-try-julia ()
;;   (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'julia "#"))

;; php
(ert-deftest evil-textobj-tree-sitter-try-php ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'php "<?php\n// howdy\n?>" (cons 7 15)))

;; python
(ert-deftest evil-textobj-tree-sitter-try-python ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'python "#"))

;; r
(ert-deftest evil-textobj-tree-sitter-try-r ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'r "#"))

;; ruby
(ert-deftest evil-textobj-tree-sitter-try-ruby ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'ruby "#"))

;; rust
(ert-deftest evil-textobj-tree-sitter-try-rust ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'rust "//"))

;; typescript
(ert-deftest evil-textobj-tree-sitter-try-typescript ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'typescript "//"))

;; verilog
(ert-deftest evil-textobj-tree-sitter-try-verilog ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'verilog "//"))

;; zig
(ert-deftest evil-textobj-tree-sitter-try-zig ()
  (evil-textobj-tree-sitter--test-loading-with-comment-prefix 'zig "//"))

;;; evil-textobj-tree-sitter-query-test.el ends here
