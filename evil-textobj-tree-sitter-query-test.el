;;; Code:

(require 'tree-sitter-langs)
(require 'evil-textobj-tree-sitter)

(defun evil-textobj-tree-sitter--test-loading-with-comment (lang comment-prefix)
  "Try loading grammar for `LANG' and test with comment using `COMMENT-PREFIX'."
  (let* ((bufname (make-temp-name "evil-textobj-tree-sitter-test--"))
         (filename (concat "/tmp/" bufname)))

    (find-file filename)
    (fundamental-mode)
    (with-current-buffer bufname
      (setq-local tree-sitter-major-mode-language-alist `((fundamental-mode . ,lang)))
      (setq-local evil-textobj-tree-sitter-major-mode-language-alist `((fundamental-mode . ,(symbol-name lang))))
      (insert (concat comment-prefix " howdy!"))
      ;; (comment-line 0)
      (tree-sitter-mode)
      (tree-sitter-hl-mode)
      (goto-char 0)
      (should (equal
               (evil-textobj-tree-sitter--range
                1
                (list (intern "comment.outer")))
               (cons 1 (+ 8 (length comment-prefix))))))

    (set-buffer-modified-p nil)
    (kill-buffer bufname)))



;; bash
(ert-deftest evil-textobj-tree-sitter-try-bash ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'bash "#"))

;; c
(ert-deftest evil-textobj-tree-sitter-try-c ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'c "//"))

;; cpp
(ert-deftest evil-textobj-tree-sitter-try-cpp ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'cpp "//"))

;; elixir
(ert-deftest evil-textobj-tree-sitter-try-elixir ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'elixir "#"))

;; elm
(ert-deftest evil-textobj-tree-sitter-try-elm ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'elm "--"))

;; go
(ert-deftest evil-textobj-tree-sitter-try-go ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'go "//"))

;; haskell
(ert-deftest evil-textobj-tree-sitter-try-haskell ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'haskell "--"))

;; hcl
(ert-deftest evil-textobj-tree-sitter-try-hcl ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'hcl "#"))

;; html <!--
;; TODO: Cannot just prefix match
;; (ert-deftest evil-textobj-tree-sitter-try-html ()
;;   (evil-textobj-tree-sitter--test-loading-with-comment 'html "<!--"))

;; java
(ert-deftest evil-textobj-tree-sitter-try-java ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'java "//"))

;; javascript
(ert-deftest evil-textobj-tree-sitter-try-javascript ()
  ;; TODO: Waiting for upstream changes to queries
  ;; (evil-textobj-tree-sitter--test-loading-with-comment 'javascript "//")
  )

;; julia
(ert-deftest evil-textobj-tree-sitter-try-julia ()
  ;; TODO: Needs grammar update
  ;; (evil-textobj-tree-sitter--test-loading-with-comment 'julia "#")
  )

;; php
(ert-deftest evil-textobj-tree-sitter-try-php ()
  ;; TODO: Figure out what the problem is
  ;; (evil-textobj-tree-sitter--test-loading-with-comment 'php "//")
  )

;; python
(ert-deftest evil-textobj-tree-sitter-try-python ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'python "#"))

;; r
(ert-deftest evil-textobj-tree-sitter-try-r ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'r "#"))

;; ruby
(ert-deftest evil-textobj-tree-sitter-try-ruby ()
  ;; TODO: Waiting for upstream changes to queries
  ;; (evil-textobj-tree-sitter--test-loading-with-comment 'ruby "#")
  )

;; rust
(ert-deftest evil-textobj-tree-sitter-try-rust ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'rust "//"))

;; typescript
(ert-deftest evil-textobj-tree-sitter-try-typescript ()
  ;; TODO: Waiting for upstream changes to queries
  ;; (evil-textobj-tree-sitter--test-loading-with-comment 'typescript "//")
  )

;; verilog
(ert-deftest evil-textobj-tree-sitter-try-verilog ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'verilog "//"))

;; zig
(ert-deftest evil-textobj-tree-sitter-try-zig ()
  (evil-textobj-tree-sitter--test-loading-with-comment 'zig "//"))

;;; evil-textobj-tree-sitter-query-test.el ends here
