# evil-textobj-treesitter

Tree-sitter powered textobjects for evil mode in Emacs.

![gif](https://meain.io/blog-videos/gifs/evil-textobj-treesitter.gif)

> This is more or less a port of [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).

This package will let you create evil textobjects using the power of
treesitter grammers. You can easily create
function,class,comment etc textobjects in multiple languages.

# Installation & Usage

I will pretty soon put this up on melpa as soon as I figure out
how to do it, but for now you can use `straight` or `quelpa` to
install. By defaul, the lib does not provide any keybindings, but it
should be relatively easy to add them.

Below is my from personal config:

```emacs-lisp
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

# Mapping textobjects

```emacs-lisp
;; bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
(define-key evil-outer-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.outer"))
;; bind `function.inner`(function block without name and args) to `f` for use in things like `vif`, `yif`
(define-key evil-inner-text-objects-map "f" (evil-textobj-treesitter-get-textobj "function.inner"))
```

We support multiple textobjects. You can find a list of available textobjects at
[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects).
We might not have support for all of them as
[emacs-tree-sitter](https://github.com/ubolonton/emacs-tree-sitter)
does not support all the same languages as of now. As for the list of
languages that we support you can check the value of
`evil-textobj-treesitter-major-mode-language-alist`.

---

_This is my first Emacs package, still just figuring things out. There
is definitely some things that I could fix on this, feel free to let
me know if there is something that I can improve._
