;;; evil-textobj-treesitter.el --- Provides evil textobjects using treesitter. -*- lexical-binding: t; -*-

;;; Commentary:
;; This package is a port of nvim-treesitter/nvim-treesitter-textobjects.
;; In fact we pulled pretty much all the queries from that repo.
;; You can do a sample map like below.
;; (define-key evil-outer-text-objects-map "f"
;;             (evil-textobj-treesitter-get-textobj "function.outer"))
;; `evil-textobj-treesitter-get-textobj' will return you a function
;; that you can use in a define-key map.  You can pass in any of the
;; supported queries as an arg of that function.  You can also pass in
;; multiple queries as a list and we will match on all of them, ranked
;; on which ones comes up first in the file.
;; You can find a list of supported queries in the
;; nvim-treesitter-textobjects repo at
;; https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects

;;; Code:

(require 'evil)
(require 'tree-sitter)

(defgroup evil-textobj-treesitter nil "Text objects based on treesitter for Evil"
  :group 'evil)

(defconst evil-textobj-treesitter--dir
  (file-name-directory (locate-library "evil-textobj-treesitter.el"))
  "The directory where the library `tree-sitter-langs' is located.")

(defconst evil-textobj-treesitter--queries-dir
  (file-name-as-directory
   (concat evil-textobj-treesitter--dir "queries")))

; TODO: document how to add more languages
(defvar evil-textobj-treesitter-queries (make-hash-table)
  "Map between `major-mode' and their language bundles of tree sitter queries.")
(puthash 'bash-mode "bash" evil-textobj-treesitter-queries)
(puthash 'bibtex-mode "bibtex" evil-textobj-treesitter-queries)
(puthash 'c-mode "c" evil-textobj-treesitter-queries)
(puthash 'csharp-mode "c_sharp" evil-textobj-treesitter-queries)
(puthash 'cpp-mode "cpp" evil-textobj-treesitter-queries)
(puthash 'dart-mode "dart" evil-textobj-treesitter-queries)
(puthash 'go-mode "go" evil-textobj-treesitter-queries)
(puthash 'html-mode "html" evil-textobj-treesitter-queries)
(puthash 'java-mode "java" evil-textobj-treesitter-queries)
(puthash 'javascript-mode "javascript" evil-textobj-treesitter-queries)
(puthash 'julia-mode "julia" evil-textobj-treesitter-queries)
(puthash 'latex-mode "latex" evil-textobj-treesitter-queries)
(puthash 'lua-mode "lua" evil-textobj-treesitter-queries)
(puthash 'php-mode "php" evil-textobj-treesitter-queries)
(puthash 'python-mode "python" evil-textobj-treesitter-queries)
(puthash 'ruby-mode "ruby" evil-textobj-treesitter-queries)
(puthash 'rust-mode "rust" evil-textobj-treesitter-queries)
(puthash 'typescript-mode "typescript" evil-textobj-treesitter-queries)

;;;###autoload
(defun evil-textobj-treesitter--nodes-within (nodes)
  "NODES which contain the current point insdie them ordered inside out."
  (sort (remove-if-not (lambda (x)
                         (and (< (car (tsc-node-byte-range x)) (point))
                              (> (cdr (tsc-node-byte-range x)) (point))))
                       nodes)
        (lambda (x y)
          (< (+ (abs (- (point)
                        (car (tsc-node-byte-range x))))
                (abs (- (point)
                        (cdr (tsc-node-byte-range x))))) (+ (abs (- (point)
                        (car (tsc-node-byte-range y))))
                (abs (- (point)
                        (cdr (tsc-node-byte-range y)))))))))

;;;###autoload
(defun evil-textobj-treesitter--nodes-after (nodes)
  "NODES which contain the current point before them ordered top to bottom."
  (remove-if-not (lambda (x)
                   (> (car (tsc-node-byte-range x)) (point)))
                 nodes))

;;;###autoload
(defun evil-textobj-treesitter--get-nodes (group count)
  "Get a list of viable nodes based on GROUP value.
They will be order with captures with point inside them first then the
ones that follow.  This will return n(COUNT) items."
  (let* ((lang-file (gethash major-mode evil-textobj-treesitter-queries))
         (query-filename (concat evil-textobj-treesitter--queries-dir lang-file
                                 "/textobjects.scm"))
         (debugging-query (with-temp-buffer
                            (insert-file-contents query-filename)
                            (buffer-string)))
         (root-node (tsc-root-node tree-sitter-tree))
         (query (tsc-make-query tree-sitter-language debugging-query))
         (captures (tsc-query-captures query root-node #'tsc--buffer-substring-no-properties))
         (filtered-captures (remove-if-not (lambda (x)
                                             (member (car x) group))
                                           captures))
         (nodes (seq-map #'cdr filtered-captures))
         (nodes-nodupes (remove-duplicates nodes
                                           :test (lambda (x y)
                                                   (and (= (car (tsc-node-byte-range x)) (car (tsc-node-byte-range y)))
                                                        (= (cdr (tsc-node-byte-range x)) (cdr (tsc-node-byte-range y)))))))
         (nodes-within (evil-textobj-treesitter--nodes-within nodes-nodupes))
         (nodes-after (evil-textobj-treesitter--nodes-after nodes-nodupes)))
    (subseq (append nodes-within nodes-after)
            0
            count)))

;;;###autoload
(defun evil-textobj-treesitter--range (count beg end type ts-group)
  "Get the range of the closeset item of type `TS-GROUP'.
Not processing `BEG', `END' as of now.  `COUNT' is supported even
thought it does not actually make sense in most cases as if we do
3-in-func the selections will not be continues, but we can only
provide the start and end as of now which is what we are doing.
`TYPE' can probably be used to append inner or outer."
  (let* ((nodes (evil-textobj-treesitter--get-nodes ts-group
                                                    count))
         (range-min (apply 'min
                           (seq-map (lambda (x)
                                      (car (tsc-node-byte-range x)))
                                    nodes)))
         (range-max (apply 'max
                           (seq-map (lambda (x)
                                      (cdr (tsc-node-byte-range x)))
                                    nodes))))
    ;; Have to compute min and max like this as we might have nested functions
    (evil-range range-min range-max)))

;;;###autoload
(defmacro evil-textobj-treesitter-get-textobj (group)
  "Macro to create a textobj function from `GROUP'.
You can pass in multiple groups as a list and in that case as long as
any one of them is vaild, it will be picked.  Check this url for
available objects https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects"
  (let* ((groups (if (eq (type-of group) 'string)
                     (list group)
                   group))
         (funsymbol (intern (concat "evil-textobj-treesitter-function--"
                                    (mapconcat 'identity groups "-"))))
         (interned-groups (map 'identity 'intern groups)))
    `(evil-define-text-object ,funsymbol
       (count &optional beg end type)
       (evil-textobj-treesitter--range count beg
                                       end type ',interned-groups))))

(provide 'evil-textobj-treesitter)
;;; evil-textobj-treesitter.el ends here
