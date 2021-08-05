# evil-textobj-treesitter

Tree-sitter powered textobjects for evil mode in Emacs.

> This is more or less a port of [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).

# Installation & Usage

I with pretty soon put this up on melpa as soon as I figure out
how to do it, but for now you can use `straight` or `quelpa` to
install.

Below is my personal config:

``` emacs-lisp
(use-package evil-textobj-treesitter
  :straight (el-patch :type git
                      :host github
                      :repo "meain/evil-textobj-treesitter"
                      :files (:defaults "queries"))
  :after tree-sitter
  :init
      (define-key evil-outer-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.outer"))
      (define-key evil-inner-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.inner"))
      (define-key evil-outer-text-objects-map "c" (evil-textobj-treesitter-get-textobj "class.outer"))
      (define-key evil-inner-text-objects-map "c" (evil-textobj-treesitter-get-textobj "class.inner"))
      (define-key evil-outer-text-objects-map "C" (evil-textobj-treesitter-get-textobj "comment.outer"))
      (define-key evil-inner-text-objects-map "C" (evil-textobj-treesitter-get-textobj "comment.outer"))
      (define-key evil-outer-text-objects-map "o" (evil-textobj-treesitter-get-textobj "loop.outer"))
      (define-key evil-inner-text-objects-map "o" (evil-textobj-treesitter-get-textobj "loop.inner"))
      (define-key evil-outer-text-objects-map "n" (evil-textobj-treesitter-get-textobj "conditional.outer"))
      (define-key evil-inner-text-objects-map "n" (evil-textobj-treesitter-get-textobj "conditionalp.inner")))
```

