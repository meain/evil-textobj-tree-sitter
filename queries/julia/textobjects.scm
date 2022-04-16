; Blocks
((compound_expression
  . (_)?  @block.inner._start
  (_)  @block.inner._end .)
) @block.outer
((let_statement
  . (_)?  @block.inner._start
  (_)  @block.inner._end .)
) @block.outer

; Calls
(call_expression
  (argument_list) @call.inner) @call.outer

; Objects (class)
((struct_definition
  name: (_)
  . (_)?  @class.inner._start
  (_)  @class.inner._end .
  "end"
)) @class.outer

((struct_definition
  name: (_) type_parameters: (_)
  . (_)?  @class.inner._start
  (_)  @class.inner._end .
  "end"
)) @class.outer

; Comments
[(line_comment) (block_comment)] @comment.outer

; Conditionals
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

; Functions
(assignment_expression 
  (call_expression (_)) 
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

((function_definition
  name: (_) parameters: (_)
  . (_)?  @function.inner._start
  (_)  @function.inner._end .
  "end"
)) @function.outer

; Loops
(for_statement
 . (_)?  @loop.inner._start
 (_)  @loop.inner._end .
 
  "end") @loop.outer
(while_statement
 . (_)?  @loop.inner._start
 (_)  @loop.inner._end .
 
  "end") @loop.outer

; Parameters
((subscript_expression
    ","  @parameter.outer._start . 
    (_) @parameter.inner @parameter.outer._end)
 ) 

((subscript_expression
    . (_) @parameter.inner @parameter.outer._start 
    . ","?  @parameter.outer._end)
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

