**We recently change the package from `evil-textobj-treesitter` to `evil-textobj-tree-sitter` (with the extra `-`). All you will have to do is to chnage the package name that you use as well as update function `evil-textobj-treesitter-get-textobj` to `evil-textobj-tree-sitter-get-textobj`. You can see the related discussion [here](https://github.com/meain/evil-textobj-tree-sitter/issues/3).**

---

# evil-textobj-tree-sitter

[![MELPA](https://melpa.org/packages/evil-textobj-treesitter-badge.svg)](https://melpa.org/#/evil-textobj-treesitter)
[![test](https://github.com/meain/evil-textobj-tree-sitter/actions/workflows/test.yaml/badge.svg)](https://github.com/meain/evil-textobj-tree-sitter/actions/workflows/test.yaml)

Tree-sitter powered textobjects for evil mode in Emacs.

![gif](https://meain.io/blog-videos/gifs/evil-textobj-treesitter.gif)

> This is more or less a port of [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).

This package will let you create evil textobjects using the power of
tree-sitter grammars. You can easily create
function,class,comment etc textobjects in multiple languages.

# Installation & Usage

You can install `evil-textobj-tree-sitter` from melpa. Here is how you would do it using `use-package`:

> **NOTE: The package will be soon renamed to `evil-textobj-tree-sitter` on [melpa](https://github.com/melpa/melpa/pull/7698)**

``` emacs-lisp
(use-package evil-textobj-tree-sitter :ensure t)
```

Or you can use straight.el:

```emacs-lisp
(use-package evil-textobj-tree-sitter
  :straight (el-patch :type git
                      :host github
                      :repo "meain/evil-textobj-tree-sitter"
                      :files (:defaults "queries")))
```
> This only works if you have properly setup [`tree-sitter`](https://github.com/emacs-tree-sitter/elisp-tree-sitter)

# Mapping textobjects

By default, the library does not provide
any keybindings, but it should be relatively easy to add them.

```emacs-lisp
;; bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
;; bind `function.inner`(function block without name and args) to `f` for use in things like `vif`, `yif`
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
```

We support multiple textobjects. You can find a list of available textobjects at
[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects).
We might not have support for all of them as
[emacs-tree-sitter](https://github.com/ubolonton/emacs-tree-sitter)
does not support all the same languages as of now. As for the list of
languages that we support you can check the value of
`evil-textobj-tree-sitter-major-mode-language-alist`.

# License

The primary codebase is licensed under `Apache-2.0`. The queries have
be taken from
[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
which is also licensed under the same license.

---

_This is my first Emacs package, still just figuring things out. There
is definitely some things that I could fix on this, feel free to let
me know if there is something that I can improve._
