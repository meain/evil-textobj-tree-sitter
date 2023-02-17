;; Blocks
((compound_statement
  . (_)?  @block.inner._start
  (_)  @block.inner._end .)
) @block.outer

((quote_statement
  . (_)?  @block.inner._start
  (_)  @block.inner._end .)
) @block.outer

((let_statement
  . (_)?  @block.inner._start
  (_)  @block.inner._end .)
) @block.outer

;; Conditionals
((if_statement condition: (_)
    . (_)?  @conditional.inner._start
    .
    (_)  @conditional.inner._end .
    ["end" (elseif_clause) (else_clause)])
) @conditional.outer
((elseif_clause condition: (_)
  . (_)?  @conditional.inner._start
  (_)  @conditional.inner._end .)
)
((else_clause
  . (_)?  @conditional.inner._start
  (_)  @conditional.inner._end .)
)

;; Loops
(for_statement
 . (_)?  @loop.inner._start
 (_)  @loop.inner._end .
 
  "end") @loop.outer
(while_statement
 . (_)?  @loop.inner._start
 (_)  @loop.inner._end .
 
  "end") @loop.outer

;; Type definitions
((struct_definition
  name: (_)
  . (_)?  @class.inner._start
  (_)  @class.inner._end .
  "end"
)) @class.outer

((struct_definition
  name: (_)
  (type_parameter_list)*
  . (_)?  @class.inner._start
  (_)  @class.inner._end .
  "end"
)) @class.outer


;; Function definitions
((function_definition
  name: (_) parameters: (_)
  . (_)?  @function.inner._start
  (_)  @function.inner._end .
  "end"
)) @function.outer

(short_function_definition
  name: (_) parameters: (_)
  (_) @function.inner) @function.outer

(function_expression 
  [ (identifier) (parameter_list) ] 
  "->"
  (_) @function.inner) @function.outer

((macro_definition
  name: (_) parameters: (_)
  . (_)?  @function.inner._start
  (_)  @function.inner._end .
  "end"
)) @function.outer

;; Calls
(call_expression) @call.outer
(call_expression
  (argument_list . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))

;; Parameters
((vector_expression
    ","  @parameter.outer._start . 
    (_) @parameter.inner @parameter.outer._end)
 ) 

((argument_list
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end)
)

((argument_list
    (_) @parameter.inner @parameter.outer._start
    . ","  @parameter.outer._end)
)

((parameter_list
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end)
)

((parameter_list
    (_) @parameter.inner @parameter.outer._start
    . [","]  @parameter.outer._end)
)

; Comments
[(line_comment) (block_comment)] @comment.outer

; Regex
((prefixed_string_literal
   prefix: (identifier) @_prefix) @regex.inner @regex.outer
 (#eq? @_prefix "r")
 (#offset! @regex.inner 0 2 0 -1))

