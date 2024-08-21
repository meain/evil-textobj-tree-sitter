; Blocks
(compound_statement) @block.outer

((compound_statement
  .
  (_)  @block.inner._start
  (_)?  @block.inner._end .)
  )

(quote_statement) @block.outer

((quote_statement
  .
  (_)  @block.inner._start
  (_)?  @block.inner._end .)
  )

(let_statement) @block.outer

((let_statement
  .
  (_)  @block.inner._start
  (_)?  @block.inner._end .)
  )

; Conditionals
(if_statement
  condition: (_) @conditional.inner) @conditional.outer

(if_statement
  alternative: (elseif_clause
    condition: (_) @conditional.inner))

((if_statement
  condition: (_)
  .
  (_)  @conditional.inner._start
  (_)?  @conditional.inner._end
  .
  [
    "end"
    (elseif_clause)
    (else_clause)
  ])
  ) @conditional.outer

((elseif_clause
  condition: (_)
  .
  (_)  @conditional.inner._start
  (_)?  @conditional.inner._end .)
  )

((else_clause
  .
  (_)  @conditional.inner._start
  (_)?  @conditional.inner._end .)
  )

; Loops
(for_statement) @loop.outer

((for_statement
  .
  (_)  @loop.inner._start
  (_)?  @loop.inner._end .)
  )

(while_statement
  condition: (_) @loop.inner) @loop.outer

((while_statement
  condition: (_)
  .
  (_)  @loop.inner._start
  (_)?  @loop.inner._end .)
  )

; Type definitions
(struct_definition) @class.outer

((struct_definition
  name: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .)
  )

; Function definitions
(function_definition) @function.outer

((function_definition
  (signature)
  .
  (_)  @function.inner._start
  (_)?  @function.inner._end .)
  )

(assignment
  (call_expression)
  (operator)
  (_) @function.inner) @function.outer

(function_expression
  [
    (identifier)
    (argument_list)
  ]
  "->"
  (_) @function.inner) @function.outer

(macro_definition) @function.outer

((macro_definition
  (signature)
  .
  (_)  @function.inner._start
  (_)?  @function.inner._end .)
  )

; Calls
(call_expression) @call.outer

(call_expression
  (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(macrocall_expression) @call.outer

(macrocall_expression
  (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(broadcast_call_expression) @call.outer

(broadcast_call_expression
  (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

; Parameters
((argument_list
  [
    ","
    ";"
  ]  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((argument_list
  (_) @parameter.inner @parameter.outer._start
  .
  [
    ","
    ";"
  ]  @parameter.outer._end)
  )

((tuple_expression
  [
    ","
    ";"
  ]  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((tuple_expression
  "("
  .
  (_) @parameter.inner @parameter.outer._start
  .
  [
    ","
    ";"
  ]?  @parameter.outer._end)
  )

((vector_expression
  [
    ","
    ";"
  ]  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((vector_expression
  .
  (_) @parameter.inner @parameter.outer._start
  .
  [
    ","
    ";"
  ]?  @parameter.outer._end)
  )

; Assignment
(assignment
  .
  (_) @assignment.lhs
  (_) @assignment.inner @assignment.rhs .) @assignment.outer

(assignment
  .
  (_) @assignment.inner)

(compound_assignment_expression
  .
  (_) @assignment.lhs
  (_) @assignment.inner @assignment.rhs .) @assignment.outer

(compound_assignment_expression
  .
  (_) @assignment.inner)

; Comments
[
  (line_comment)
  (block_comment)
] @comment.outer

; Regex
((prefixed_string_literal
  prefix: (identifier) @_prefix) @regex.inner @regex.outer
  (#eq? @_prefix "r")
  (#offset! @regex.inner 0 2 0 -1))

