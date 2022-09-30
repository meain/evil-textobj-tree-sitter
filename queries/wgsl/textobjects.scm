(function_declaration) @function.outer

(function_declaration
  body: (compound_statement . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

((parameter_list
  ","  @parameter.outer._start . (parameter) @parameter.inner @parameter.outer._end)
 )
((parameter_list
  . (parameter) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

(compound_statement) @block.outer

; loops
(loop_statement
  (_)? @loop.inner) @loop.outer
(for_statement
  (_)? @loop.inner) @loop.outer
(while_statement
  (_)? @loop.inner) @loop.outer

((struct_declaration
   "{" . _  @class.inner._start _  @class.inner._end . "}") @class.outer
 )

; conditional
(if_statement
  consequence: (_)? @conditional.inner
  alternative: (_)? @conditional.inner
  ) @conditional.outer

(if_statement
  condition: (_) @conditional.inner)

((argument_list_expression
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((argument_list_expression
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

