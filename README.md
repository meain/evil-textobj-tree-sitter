# evil-textobj-treesitter

Tree-sitter powered textobjects for evil mode in Emacs.

![gif](https://meain.io/blog-videos/gifs/evil-textobj-treesitter.gif)

> This is more or less a port of [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).

# Installation & Usage

I with pretty soon put this up on melpa as soon as I figure out
how to do it, but for now you can use `straight` or `quelpa` to
install. By defaul, the lib does not provide any keybindings, but it
should be relatively easy to add them.

Below is my from personal config:

``` emacs-lisp
(use-package evil-textobj-treesitter
  :straight (el-patch :type git
                      :host github
                      :repo "meain/evil-textobj-treesitter"
                      :files (:defaults "queries"))
  :after tree-sitter
  :config
      (define-key evil-outer-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.outer"))
      (define-key evil-inner-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.inner"))
      (define-key evil-outer-text-objects-map "c" (evil-textobj-treesitter-get-textobj "class.outer"))
      (define-key evil-inner-text-objects-map "c" (evil-textobj-treesitter-get-textobj "class.inner")))
```

---

*This is my first Emacs package, still just figuring things out. There
is definitely some things that I could fix on this, feel free to let
me know if there is something that I can improve.*
