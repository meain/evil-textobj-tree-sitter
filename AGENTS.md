## Project Overview

An Emacs package providing tree-sitter powered text objects for `evil-mode` and `thing-at-point`. Works with both `elisp-tree-sitter` and the builtin `treesit` library (Emacs 29+).

## Build & Test Commands

Dependencies are managed via Cask (`Cask` file). Install with `cask install`.

- **Compile:** `make compile`
- **Lint:** `make lint` (package-lint on the main .el file)
- **Checkdoc:** `make checkdoc`
- **Run tests:** `make test` (core functionality tests using ert)
- **Run query tests:** `make test-queries` (per-language query loading tests)
- **Converter tests:** `cd converter && go test -v`

All make targets use `cask exec emacs` under the hood. The `elpa` target runs `cask install` automatically when needed.

## Architecture

### Elisp Modules

- `evil-textobj-tree-sitter.el` — Entry point; requires core and thing-at-point modules
- `evil-textobj-tree-sitter-core.el` — All core logic: query loading, node filtering, range computation, textobj/goto functions. Supports dual backends (`elisp-tree-sitter` vs builtin `treesit`) detected at runtime
- `evil-textobj-tree-sitter-thing-at-point.el` — Registers tree-sitter things (function, loop, conditional, etc.) with Emacs `thing-at-point`

### Query System (Two Separate Sets)

- `queries/` — For `elisp-tree-sitter`, sourced from [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects). Uses `#make-range!` directives
- `treesit-queries/` — For builtin `treesit`, sourced from [Helix editor](https://github.com/helix-editor/helix). Updated via `scripts/get-helix-queries`
- `additional-queries/` — Extra queries appended to treesit-queries during the build step for cases helix doesn't cover
- `fixtures/` — Test query files for unit tests

The correct query directory is selected at runtime based on whether the current buffer uses a `-ts-mode` (treesit) or regular mode (elisp-tree-sitter).

### Converter (Go)

`converter/` contains a Go program that transforms nvim-treesitter query format (with `#make-range!` directives) into the `_start`/`_end` capture format used by `elisp-tree-sitter`. Used by `scripts/get-neovim-queries`.

### Scripts

- `scripts/get-neovim-queries` — Pulls queries from nvim-treesitter-textobjects into `queries/`
- `scripts/get-helix-queries` — Pulls queries from Helix into `treesit-queries/`, appending `additional-queries/`
- `scripts/fix-queries` — Post-processing fixups on query files

### Key Design Details

- `evil-textobj-tree-sitter-major-mode-language-alist` maps Emacs major modes to tree-sitter language names (including both regular and `-ts-mode` variants)
- Query files support `;; inherits:` directives for language inheritance (e.g., typescript inherits javascript)
- Node selection priority: nodes containing point (innermost first), then nodes after point
- `evil-textobj-tree-sitter-use-next-if-not-within` controls whether to fall through to next match when not inside one
- Tests run against both `elisp-tree-sitter` and `treesit` backends (e.g., `c-mode` and `c-ts-mode`)
