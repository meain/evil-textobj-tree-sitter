;;; translate-helix-regexps.el --- Rewrite Helix #match regexps as Emacs regexps -*- lexical-binding: t -*-

;;; Commentary:
;; Helix evaluates the `#match' patterns in its queries as Rust regexes;
;; builtin treesit evaluates them as Emacs regexps, where `(', `)' and
;; `|' are literal characters.  `scripts/get-helix-queries' runs this on
;; each query file it copies from Helix (after its sed rewrites, so every
;; `#match' is written pattern first), before additional queries are
;; appended, with `evil-textobj-tree-sitter-translate-helix-files'.
;;
;; Run it only on fresh copies: an Emacs regexp is not valid input.

;;; Code:

(defun evil-textobj-tree-sitter--query-string-decode (s)
  "Return the string that S denotes as the body of a query string literal."
  (replace-regexp-in-string "\\\\\\([\\\"]\\)" "\\1" s t))

(defun evil-textobj-tree-sitter--query-string-encode (s)
  "Return S written as the body of a query string literal."
  (replace-regexp-in-string "[\\\"]" "\\\\\\&" s t))

(defun evil-textobj-tree-sitter--treesit-match-regexp (regexp)
  "Translate REGEXP from Rust regex syntax to an Emacs regexp.
Outside a bracket expression, this turns the groups `(...)' and
`(?:...)' and the alternation `|' into their Emacs forms, and the Rust
escapes for literal parens and bars into plain characters.  Bracket
expressions and everything else are copied unchanged.  Rust-only
features such as `\\d', `\\w', `\\b', `{n,m}' and lookaround are not
translated; the Helix queries don't use them."
  (let ((i 0) (n (length regexp)) (in-class nil) (out nil))
    (while (< i n)
      (let ((c (aref regexp i)))
        (cond
         (in-class
          (push (string c) out)
          (when (eq c ?\]) (setq in-class nil)))
         ((and (eq c ?\\) (< (1+ i) n))
          (let ((next (aref regexp (1+ i))))
            (push (if (memq next '(?\( ?\) ?|)) (string next) (string c next)) out)
            (setq i (1+ i))))
         ((eq c ?\[)
          (push "[" out)
          (setq in-class t)
          ;; A leading `^', and a `]' right after the opening bracket (or
          ;; the `^'), belong to the class instead of ending it.
          (when (and (< (1+ i) n) (eq (aref regexp (1+ i)) ?^))
            (push "^" out)
            (setq i (1+ i)))
          (when (and (< (1+ i) n) (eq (aref regexp (1+ i)) ?\]))
            (push "]" out)
            (setq i (1+ i))))
         ((and (eq c ?\() (string-prefix-p "?:" (substring regexp (1+ i))))
          (push "\\(?:" out)
          (setq i (+ i 2)))
         ((memq c '(?\( ?\) ?|))
          (push (string ?\\ c) out))
         (t (push (string c) out))))
      (setq i (1+ i)))
    (apply #'concat (nreverse out))))

(defun evil-textobj-tree-sitter--translate-match-regexps (query)
  "Translate the regexp of each (#match \"re\" @c) in QUERY to Emacs syntax."
  (replace-regexp-in-string
   "(#match[[:space:]]+\"\\(\\(?:[^\"\\\\]\\|\\\\.\\)*\\)\""
   (lambda (m)
     (let ((literal (match-string 1 m)))
       (save-match-data
         (evil-textobj-tree-sitter--query-string-encode
          (evil-textobj-tree-sitter--treesit-match-regexp
           (evil-textobj-tree-sitter--query-string-decode literal))))))
   query t t 1))

(defun evil-textobj-tree-sitter-translate-helix-files ()
  "Translate the `#match' regexps in the files named on the command line."
  (dolist (file command-line-args-left)
    (with-temp-file file
      (insert (evil-textobj-tree-sitter--translate-match-regexps
               (with-temp-buffer
                 (insert-file-contents file)
                 (buffer-string))))))
  (setq command-line-args-left nil))

(provide 'translate-helix-regexps)
;;; translate-helix-regexps.el ends here
