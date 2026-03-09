# Doc for updating neovim queries

We need to manually edit the neovim queries after pulling it down as we currently do not support all query formats that are available within Neovim in Emacs.

1. Run the `./scripts/get-neovim-queries` command to pull down the latest update of neovim queries.
2. Fix things we don't support (see below). Use previous version of same query if they are available from the diff, but skip them otherwise.
3. Grep for unsupported predicates and make sure none remain: `grep -rn '#offset!\|#any-of?\|#not-any-of?\|#not-lua-match?\|#lua-match?' queries/`
4. Verify all parentheses are balanced (see "Ensuring balanced brackets" below).
5. Run tests: `make test && make test-queries`


## Things we do not support

These are Neovim-specific predicates/directives that `elisp-tree-sitter` does not handle.
Queries using these need to be manually removed or rewritten using the previous
version of the same query from the diff.

- `#offset!` — Neovim directive to adjust capture boundaries (e.g., trimming comment markers). Not a standard tree-sitter predicate.
- `#not-lua-match?` — Neovim-specific Lua pattern negation. Note: `#lua-match?` is auto-converted to `#match?` by `fix-queries`, and `#not-lua-match?` becomes `#not-match?` via the same sed rule. However, verify the conversion happened; if not, manually replace `#not-lua-match?` with `#not-match?`.
- `#any-of?` — Set membership check. May be silently ignored by older versions of the tree-sitter C library bundled in `elisp-tree-sitter`, leading to false-positive matches.
- `#not-any-of?` — Negated set membership. Same concern as `#any-of?`.

### How to fix each unsupported predicate

**`#offset!`**: Do NOT blindly delete the `(#offset! ...)` line — it is
often the last expression inside a surrounding `(...)` form, and removing
it without also fixing the closing parenthesis will leave unbalanced
brackets. Instead, remove the entire `(#offset! ...)` expression and
make sure the enclosing pattern still has balanced parentheses. For
example:

```scheme
;; Before (with #offset!):
(if_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

;; After (remove #offset! line, keep closing paren):
(if_statement
  condition: (_) @conditional.inner)
```

**`#any-of?`**: Convert to `#match?` with regex alternation, or expand
into separate patterns each using `#eq?`.

```scheme
;; Before:
(#any-of? @name "foo" "bar" "baz")

;; Option 1 — #match? (preferred when there are many values):
(#match? @name "^(foo|bar|baz)$")

;; Option 2 — duplicate pattern with #eq? (preferred for few values):
;; Copy the entire enclosing pattern once per value, each with:
(#eq? @name "foo")
```

**`#not-any-of?`**: Convert to multiple `#not-eq?` predicates (AND
semantics — all must hold).

```scheme
;; Before:
(#not-any-of? @name "do" "while" "when")

;; After:
(#not-eq? @name "do")
(#not-eq? @name "while")
(#not-eq? @name "when")
```

**`#not-lua-match?`**: Replace with `#not-match?` (adjusting the pattern
from Lua pattern syntax to regex if needed).

## Ensuring balanced brackets

After making edits, verify that every query file has balanced
parentheses and square brackets. A quick check:

```sh
# Note: must strip string literals first since queries contain "(" and
# similar inside strings which would throw off a naive character count.
for f in queries/*/textobjects.scm; do
  stripped=$(sed 's/"[^"]*"//g' "$f")
  opens=$(echo "$stripped" | tr -cd '(' | wc -c)
  closes=$(echo "$stripped" | tr -cd ')' | wc -c)
  if [ "$opens" -ne "$closes" ]; then
    echo "UNBALANCED parens in $f: (=$opens )=$closes"
  fi
  opens=$(echo "$stripped" | tr -cd '[' | wc -c)
  closes=$(echo "$stripped" | tr -cd ']' | wc -c)
  if [ "$opens" -ne "$closes" ]; then
    echo "UNBALANCED brackets in $f: [=$opens ]=$closes"
  fi
done
```

If any file is reported as unbalanced, open it and fix the issue before
running tests.

## Things that are supported
- `#eq?` — Standard tree-sitter equality predicate, works as-is.
- `#not-eq?` — Standard negated equality, works as-is.
- `#match?` — Standard regex matching, works as-is.
- `#not-match?` — Standard negated regex matching, works as-is.
- `#make-range!` — Neovim-specific, but handled by the Go converter in `converter/` which transforms it to `_start`/`_end` captures.
