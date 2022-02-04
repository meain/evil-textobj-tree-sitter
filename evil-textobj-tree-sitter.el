;;; evil-textobj-tree-sitter.el --- Provides evil textobjects using tree-sitter -*- lexical-binding: t; -*-

;; URL: https://github.com/meain/evil-textobj-tree-sitter
;; Keywords: evil, tree-sitter, text-object, convenience
;; SPDX-License-Identifier: Apache-2.0
;; Package-Requires: ((emacs "25.1") (evil "1.0.0") (tree-sitter "0.15.0"))
;; Version: 0.1

;;; Commentary:
;; This package is a port of nvim-treesitter/nvim-treesitter-textobjects.
;; This package will let you create evil textobjects using the power
;; of tree-sitter grammars.  You can easily create
;; function,class,comment etc textobjects in multiple languages.
;;
;; You can do a sample map like below to create a function textobj.
;; (define-key evil-outer-text-objects-map "f"
;;             (evil-textobj-tree-sitter-get-textobj "function.outer"))
;; `evil-textobj-tree-sitter-get-textobj' will return you a function
;; that you can use in a define-key map.  You can pass in any of the
;; supported queries as an arg of that function.  You can also pass in
;; multiple queries as a list and we will match on all of them, ranked
;; on which ones comes up first in the file.
;; You can find more info in the  README.md file at
;; https://github.com/meain/evil-textobj-tree-sitter

;;; Code:

(require 'cl-lib)
(require 'evil)
(require 'tree-sitter)

(defgroup evil-textobj-tree-sitter nil "Text objects based on tree-sitter for Evil"
  :group 'evil)

(defconst evil-textobj-tree-sitter--dir (file-name-directory (locate-library "evil-textobj-tree-sitter.el"))
  "The directory where the library `tree-sitter-langs' is located.")

(defconst evil-textobj-tree-sitter--queries-dir (file-name-as-directory (concat evil-textobj-tree-sitter--dir "queries")))

(defcustom evil-textobj-tree-sitter-major-mode-language-alist nil
  "Alist that maps major modes to tree-sitter language names."
  :group 'evil-textobj-tree-sitter
  :type '(alist :key-type symbol
                :value-type string))
(pcase-dolist (`(,major-mode . ,lang-symbol)
               (reverse '((sh-mode . "bash")
                          (shell-script-mode . "bash")
                          (c-mode . "c")
                          (csharp-mode . "csharp")
                          (c++-mode . "cpp")
                          (go-mode . "go")
                          (html-mode . "html")
                          (java-mode . "java")
                          (javascript-mode . "javascript")
                          (js-mode . "javascript")
                          (js2-mode . "javascript")
                          (js3-mode . "javascript")
                          (julia-mode . "julia")
                          (php-mode . "php")
                          (python-mode . "python")
                          (rjsx-mode . "javascript")
                          (ruby-mode . "ruby")
                          (rust-mode . "rust")
                          (rustic-mode . "rust")
                          (typescript-mode . "typescript"))))
  (setf (map-elt evil-textobj-tree-sitter-major-mode-language-alist
                 major-mode) lang-symbol))

(defun evil-textobj-tree-sitter--nodes-before (nodes)
  "NODES which contain the current after them."
  (cl-remove-if-not (lambda (x)
                      (< (byte-to-position (cdr (tsc-node-byte-range x))) (point)))
                    nodes))

(defun evil-textobj-tree-sitter--nodes-within (nodes)
  "NODES which contain the current point inside them ordered inside out."
  (let ((byte-pos (position-bytes (point))))
    (sort (cl-remove-if-not (lambda (x)
                              (and (<= (car (tsc-node-byte-range x)) byte-pos)
                                   (< byte-pos (cdr (tsc-node-byte-range x)))))
                            nodes)
          (lambda (x y)
            (< (+ (abs (- byte-pos
                          (car (tsc-node-byte-range x))))
                  (abs (- byte-pos
                          (cdr (tsc-node-byte-range x))))) (+ (abs (- byte-pos
                          (car (tsc-node-byte-range y))))
                  (abs (- byte-pos
                          (cdr (tsc-node-byte-range y))))))))))

(defun evil-textobj-tree-sitter--nodes-after (nodes)
  "NODES which contain the current point before them ordered top to bottom."
  (cl-remove-if-not (lambda (x)
                      (> (byte-to-position (car (tsc-node-byte-range x))) (point)))
                    nodes))

(defun evil-textobj-tree-sitter--get-query (language top-level)
  "Get tree sitter query for LANGUAGE.
TOP-LEVEL is used to mention if we should load optional inherits.
https://github.com/nvim-treesitter/nvim-treesitter/pull/564"
  (with-temp-buffer
    (let ((filename (concat evil-textobj-tree-sitter--queries-dir
                            language "/textobjects.scm")))
      (if (file-exists-p filename)
          (progn
            (insert-file-contents filename)
            (goto-char (point-min))
            (let* ((first-line (thing-at-point 'line t))
                   (first-line-matches (save-match-data (when (string-match "^; *inherits *:? *\\([a-z_,()]+\\) *$"
                                                                            first-line)
                                                          (match-string 1 first-line)))))
              (if first-line-matches
                  (insert (string-join (mapcar (lambda (x)
                                                 (if (string-prefix-p "(" x)
                                                     (if top-level
                                                         (evil-textobj-tree-sitter--get-query (substring x 1 -1)
                                                                                              nil))
                                                   (evil-textobj-tree-sitter--get-query x nil)))
                                               (split-string first-line-matches ","))
                                       "\n"))))
            (buffer-string))))))

(defun evil-textobj-tree-sitter--get-nodes (group query)
  "Get a list of viable nodes based on `GROUP' value.
They will be order with captures with point inside them first then the
ones that follow.  If a `QUERY' alist is provided, we make use of that
instead of the builtin query set."
  (let* ((lang-name (alist-get major-mode evil-textobj-tree-sitter-major-mode-language-alist))
         (debugging-query (if (eq query nil)
                              (evil-textobj-tree-sitter--get-query lang-name
                                                                   t)
                            (alist-get major-mode query)))
         (root-node (tsc-root-node tree-sitter-tree))
         (query (tsc-make-query tree-sitter-language debugging-query))
         (captures (tsc-query-captures query root-node #'tsc--buffer-substring-no-properties))
         (filtered-captures (cl-remove-if-not (lambda (x)
                                                (member (car x) group))
                                              captures))
         (nodes (seq-map #'cdr filtered-captures)))
    (cl-remove-duplicates nodes
                          :test (lambda (x y)
                                  (and (= (car (tsc-node-byte-range x)) (car (tsc-node-byte-range y)))
                                       (= (cdr (tsc-node-byte-range x)) (cdr (tsc-node-byte-range y))))))))

(defun evil-textobj-tree-sitter--get-within-and-after (group count query)
  "Given a `GROUP' `QUERY' find `COUNT' number of nodes within in and after current point."
  (let* ((nodes (evil-textobj-tree-sitter--get-nodes group
                                                     query))
         (nodes-within (evil-textobj-tree-sitter--nodes-within nodes))
         (nodes-after (evil-textobj-tree-sitter--nodes-after nodes))
         (filtered-nodes (append nodes-within nodes-after)))
    (if (> (length filtered-nodes) 0)
        (cl-subseq filtered-nodes 0 count))))

(defun evil-textobj-tree-sitter--range (count ts-group &optional query)
  "Get the range of the closeset item of type `TS-GROUP'.
`COUNT' is supported even thought it does not actually make sense in
most cases as if we do 3-in-func the selections will not be continues,
but we can only provide the start and end as of now which is what we
are doing.  If a `QUERY' alist is provided, we make use of that
instead of the builtin query set."
  (if (equal tree-sitter-mode nil)
      (message "tree-sitter-mode not enabled for buffer")
    (let ((nodes (evil-textobj-tree-sitter--get-within-and-after
                  ts-group count query)))
      (if (not (eq nodes nil))
          (let ((range-min (apply #'min
                                  (seq-map (lambda (x)
                                             (car (tsc-node-byte-range x)))
                                           nodes)))
                (range-max (apply #'max
                                  (seq-map (lambda (x)
                                             (cdr (tsc-node-byte-range x)))
                                           nodes))))
            ;; Have to compute min and max like this as we might have nested functions
            ;; We have to use `cl-callf byte-to-position` ot the positioning might be off for unicode chars
            (cons (cl-callf byte-to-position range-min) (cl-callf byte-to-position range-max)))))))

;;;###autoload
(defmacro evil-textobj-tree-sitter-get-textobj (group &optional query)
  "Macro to create a textobj function from `GROUP'.
You can pass in multiple groups as a list and in that case as long as
any one of them is available, it will be picked.

You can optionally pass in a alist mapping `major-mode' to their
respective tree-sitter query in `QUERY' with named captures to use
that instead of the default query list.  Check the README file in the
repo to see how to use it.

Check this url for builtin objects
https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects"
  (declare (debug t) (indent defun))
  (let* ((groups (if (eq (type-of group) 'string)
                     (list group)
                   group))
         (funsymbol (intern (concat "evil-textobj-tree-sitter-function--"
                                    (mapconcat 'identity groups "-"))))
         (interned-groups (mapcar #'intern groups)))
    `(evil-define-text-object ,funsymbol
       ;; rest argument is named because of compiler warning `argument _ not left unused`
       (count &rest unused)
       (let ((range (evil-textobj-tree-sitter--range count ',interned-groups
                                                     ,query)))
         (if (not (eq range nil))
             (evil-range (car range)
                         (cdr range))
           (message (concat "No '" ,group "' text object found")))))))

(defun evil-textobj-tree-sitter--get-goto-location (groups previous end query)
  "Get the start/end of the textobj of type `GROUPS'.
By default it goes to the start of the textobj, but pass in `END' if
you want to go to the end of the textobj instead.  You can pass in
`PREVIOUS' if you want to search backwards.  `QUERY' for custom queries."
  (let* ((nodes (evil-textobj-tree-sitter--get-nodes groups
                                                     query))
         (nodes-before (reverse (evil-textobj-tree-sitter--nodes-before nodes)))
         (nodes-within (evil-textobj-tree-sitter--nodes-within nodes))
         (nodes-after (evil-textobj-tree-sitter--nodes-after nodes))
         (node (car (if previous
                        (if end
                            nodes-before
                          (cl-remove-if (lambda (x)
                                          "Remove the item if we already on the start of that one."
                                          (= (byte-to-position (car (tsc-node-byte-range x))) (point)))
                                        (cl-merge 'list nodes-within nodes-before
                                                  (lambda (x y) (> (car (tsc-node-byte-range x))
                                                                   (car (tsc-node-byte-range y)))))))
                      (if end
                          (cl-remove-if (lambda (x)
                                          "Remove the item if we already on the end of that one."
                                          (= (- (byte-to-position (cdr (tsc-node-byte-range x))) 1) (point)))
                                        (cl-merge 'list nodes-within nodes-after
                                                  (lambda (x y) (< (cdr (tsc-node-byte-range x))
                                                                   (cdr (tsc-node-byte-range y))))))
                        nodes-after)))))
    (if node
        (let ((actual-position (cl-callf byte-to-position
                                   (if end
                                       (cdr (tsc-node-byte-range node))
                                     (car (tsc-node-byte-range node))))))
          (if end
              ;; tree sitter count + 1 kinda (probably have to look in other places as well)
              ;; This is a mess that evil creates (not really an issue in Emacs mode)
              (- actual-position 1)
            actual-position)))))

;;;###autoload
(defun evil-textobj-tree-sitter-goto-textobj (group &optional previous end query)
  "Got to the start/end of the textobj of type `GROUP'.
By default it goes to the start of the textobj, but pass in `END' if
you want to go to the end of the textobj instead.  You can pass in
`PREVIOUS' if you want to search backwards.  Optionally pass in
`QUERY' if you want to define a custom query."
  (let* ((groups (if (eq (type-of group) 'string)
                     (list group)
                   group))
         (interned-groups (mapcar #'intern groups))
         (goto-position (evil-textobj-tree-sitter--get-goto-location
                         interned-groups previous end query)))
    (if goto-position
        (goto-char goto-position)
      (message (concat "No '" group "' text object found")))))

(provide 'evil-textobj-tree-sitter)
;;; evil-textobj-tree-sitter.el ends here
