
; https://fennel-lang.org/reference

(comment) @comment.outer

(_ . "(" ")" .) @statement.outer

; functions
((fn . name: (_)? . (parameters) . docstring: (_)? . (_)  @function.inner._start . (_)* . (_)?  @function.inner._end .)
 ) @function.outer

((lambda . name: (_)? . (parameters) . docstring: (_)? . (_)  @function.inner._start . (_)* . (_)?  @function.inner._end .)
 ) @function.outer

(hashfn ["#" "hashfn"] @function.outer.start (_) @function.inner) @function.outer

; parameters
(parameters (_) @parameter.inner)
(parameters (_) @parameter.outer)

; call
((list . [(multi_symbol) (symbol)] @call.inner) @call.outer
 (#not-any-of? @call.inner "if" "do" "while" "for" "let" "when"))


; conditionals
((list . ((symbol) @_if (#any-of? @_if "if" "when")) . (_) .
  (_)  @conditional.inner._start .
  (_)* .
  (_)?  @conditional.inner._end .)
 ) @conditional.outer


; loops
((for . (for_clause) .
  (_)  @loop.inner._start .
  (_)* .
  (_)?  @loop.inner._end .)
 ) @loop.outer

((each . (_) .
  (_)  @loop.inner._start .
  (_)* .
  (_)?  @loop.inner._end .)
 ) @loop.outer

((list . ((symbol) @_while (#eq? @_while "while")) . (_) .
  (_)  @loop.inner._start .
  (_)* .
  (_)?  @loop.inner._end .)
 ) @loop.outer


