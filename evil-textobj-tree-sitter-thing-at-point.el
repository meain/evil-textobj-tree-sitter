;;; evil-textobj-tree-sitter-thing-at-point.el --- Provides thing-at-point integration for tree-sitter textobjects -*- lexical-binding: t; -*-

;; URL: https://github.com/meain/evil-textobj-tree-sitter
;; Keywords: evil, tree-sitter, text-object, convenience
;; SPDX-License-Identifier: Apache-2.0
;; Package-Requires: ((emacs "25.1"))
;; Version: 0.1

;;; Commentary:
;; This adds `thing-at-point' things powered by tree-sitter.

;; Suggestion for package which could help improve the use for this
;; https://github.com/plandes/mark-thing-at

;;; Code:
(require 'thingatpt)
(require 'evil-textobj-tree-sitter-core)

(defun evil-textobj-tree-sitter--thing-at-point-bounds (group)
  "Return the bounds of the `GROUP' at point."
  (when-let* ((entity (evil-textobj-tree-sitter--get-within (list (intern group)) 1 nil))
              (pos (cdr (car entity))))
    (cons (car pos) (cadr pos))))

(put 'function 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "function.outer")))
(put 'loop 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "loop.outer")))
(put 'conditional 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "conditional.outer")))
(put 'assignment 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "assignment.outer")))
(put 'class 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "class.outer")))
(put 'comment 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "comment.outer")))
(put 'parameter 'bounds-of-thing-at-point (lambda () (evil-textobj-tree-sitter--thing-at-point-bounds "parameter.outer")))

;;;###autoload
(defun function-at-point ()
  "Return the function at point, or nil if none is found."
  (thing-at-point 'function))

;;;###autoload
(defun loop-at-point ()
  "Return the loop at point, or nil if none is found."
  (thing-at-point 'loop))

;;;###autoload
(defun conditional-at-point ()
  "Return the conditional at point, or nil if none is found."
  (thing-at-point 'conditional))

;;;###autoload
(defun assignment-at-point ()
  "Return the assignment at point, or nil if none is found."
  (thing-at-point 'assignment))

;;;###autoload
(defun class-at-point ()
  "Return the class at point, or nil if none is found."
  (thing-at-point 'class))

;;;###autoload
(defun comment-at-point ()
  "Return the comment at point, or nil if none is found."
  (thing-at-point 'comment))

;;;###autoload
(defun parameter-at-point ()
  "Return the parameter at point, or nil if none is found."
  (thing-at-point 'parameter))

(provide 'evil-textobj-tree-sitter-thing-at-point)
;;; evil-textobj-tree-sitter-thing-at-point.el ends here
