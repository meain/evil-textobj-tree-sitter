# evil-textobj-tree-sitter

[![MELPA](https://melpa.org/packages/evil-textobj-tree-sitter-badge.svg)](https://melpa.org/#/evil-textobj-tree-sitter)
[![test](https://github.com/meain/evil-textobj-tree-sitter/actions/workflows/test.yaml/badge.svg)](https://github.com/meain/evil-textobj-tree-sitter/actions/workflows/test.yaml)

Tree-sitter powered textobjects for Emacs. You can use them with `evil-mode` or with `thing-at-point`.

![gif](https://meain.io/blog-videos/gifs/evil-textobj-treesitter.gif)

This package will let you create evil textobjects using tree-sitter
grammars. You can easily create function,class,comment etc textobjects
in multiple languages. It also make additional `things` available in
`thing-at-point` like `function`, `class`, `loop`, `comment` etc.

> It can work with either elisp-tree-sitter or the builtin treesit library.

# Installation

You can install `evil-textobj-tree-sitter` from melpa. Here is how you would do it using `use-package` and `package.el`:

```emacs-lisp
(use-package evil-textobj-tree-sitter :ensure t)
```

Or you can use `straight.el`:

```emacs-lisp
(use-package evil-textobj-tree-sitter :straight t)
```

Or using `straight.el` and `el-get` to pull from source:

```emacs-lisp
(use-package evil-textobj-tree-sitter
  :straight (evil-textobj-tree-sitter :type git
                      :host github
                      :repo "meain/evil-textobj-tree-sitter"
                      :files (:defaults "queries")))
```

> You will also have to setup [`tree-sitter`](https://github.com/emacs-tree-sitter/elisp-tree-sitter).

# Usage

## `thing-at-point` additions

The package adds more "things" to `thing-at-point`. You can find all
the things that it adds in the
[source](https://github.com/meain/evil-textobj-tree-sitter/blob/master/evil-textobj-tree-sitter-thing-at-point.el).

You can use these like any other `thing-at-point` entries. For example
in case of functions, we make the following available:

- `(thing-at-point 'function)`
- `(function-at-point)`

## Mapping textobjects

By default, the library does not provide any keybindings, but it
should be relatively easy to add them.

```emacs-lisp
;; bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
;; bind `function.inner`(function block without name and args) to `f` for use in things like `vif`, `yif`
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))

;; You can also bind multiple items and we will match the first one we can find
(define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj ("conditional.outer" "loop.outer")))
```

## Custom textobjects

If you are not able to find the text object that you are looking for
in the builtin list, you can create custom text objects by passing the
a custom query with captures.

For example if you want to create text object to select `import`
statements, you can write something like below. _You will have to
provide the tree-sitter queries for all the languages that you want it
to work for_

```emacs-lisp
;; The first arguemnt to `evil-textobj-tree-sitter-get-textobj' will be the capture group to use
;; and the second arg will be an alist mapping major-mode to the corresponding query to use.
(define-key evil-outer-text-objects-map "m" (evil-textobj-tree-sitter-get-textobj "import"
                                              '((python-mode . [(import_statement) @import])
                                                (rust-mode . [(use_declaration) @import]))))
```

## Goto

We have also added support for for a fancier version of
`goto-char`. You can use this to go to the next function, previous
class or do any motions like that.

You can use the `evil-textobj-tree-sitter-goto-textobj` function to
invoke goto. You can either use this in other function or just bound
to a key. The first argument is the textobj that you want to use, the
second one specifies if you want to search forward or backward and the
last one is for specifying weather to go to the start or end of the
textobj.

Below are some sample binding that you can do. You can use any textobj
that is available here.

```emacs-lisp
;; Goto start of next function
(define-key evil-normal-state-map (kbd "]f") (lambda ()
                                                  (interactive)
                                                  (evil-textobj-tree-sitter-goto-textobj "function.outer")))
;; Goto start of previous function
(define-key evil-normal-state-map (kbd "[f") (lambda ()
                                                  (interactive)
                                                  (evil-textobj-tree-sitter-goto-textobj "function.outer" t)))
;; Goto end of next function
(define-key evil-normal-state-map (kbd "]F") (lambda ()
                                                  (interactive)
                                                  (evil-textobj-tree-sitter-goto-textobj "function.outer" nil t)))
;; Goto end of previous function
(define-key evil-normal-state-map (kbd "[F") (lambda ()
                                                  (interactive)
                                                  (evil-textobj-tree-sitter-goto-textobj "function.outer" t t)))
```

# Finding and contributing to textobjects

`evil-textobj-tree-sitter` work with both builtin `treesit` and
`elisp-tree-sitter`. The queries in use are a bit different in both
cases with the `elisp-tree-sitter` version currently being more feature
complete. In both cases we pull the queries from external sources. For
`elisp-tree-sitter`, we source them from
[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects)
and is places into
[queries](https://github.com/meain/evil-textobj-tree-sitter/tree/master/queries)
directory. And for `treesit` queries, it is sourced from
[helix](https://github.com/helix-editor/helix/tree/master/runtime/queries)
and placed in
[treesit-queries](https://github.com/meain/evil-textobj-tree-sitter/tree/master/treesit-queries).
You can check these files to see what all is available. If you are
interesting in contributing additional textobjects, you can do so by
submitting to the respective projects. If there is enough interest, I
don't mind starting to manage queries ourselves.

If you are adding a completely new language, there is two other things
that you will have to do to make sure everything will work well.

1. Make sure the lang is available in [emacs-tree-sitter/tree-sitter-langs](https://github.com/emacs-tree-sitter/tree-sitter-langs/tree/master/queries) or `treesit`.
2. Make sure we have a `major-mode` mapping in [evil-textobj-tree-sitter-major-mode-language-alist](https://github.com/meain/evil-textobj-tree-sitter/blob/d416b3ab8610f179defadd58f5c20fdc65bf21e5/evil-textobj-tree-sitter.el#L40)

*If you would like to test out new textobjects, I would suggest using
[custom textobjects](#custom-textobjects). If you want to edit the
query files, you can edit them in
`evil-textobj-tree-sitter--queries-dir` or by forking the repo, and
using the forked version with your edits.*

# License

The primary codebase is licensed under `Apache-2.0`. The queries have
be taken from
[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
which is also licensed under the same license.
