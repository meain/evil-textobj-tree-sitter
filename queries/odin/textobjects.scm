; procedures
(procedure_declaration
  (_
    (block
      .
      "{"
      .
      (_)  @function.inner._start  @function.inner._end
      (_)?  @function.inner._end
      .
      "}"
      ))) @function.outer

; returns
(return_statement
  (_)? @return.inner) @return.outer

; call function in module
(member_expression
  (call_expression)) @call.outer

; plain call
((_
  (call_expression) @call.outer) @_parent
  (#not-kind-eq? @_parent "member_expression"))

; call arguments
((call_expression
  function: (_)
  .
  argument: (_) @_first @call.inner._start
  argument: (_) @_last @call.inner._end .)
  )

; block
(block
  .
  "{"
  .
  (_)  @block.inner._start  @block.inner._end
  (_)?  @block.inner._end
  .
  "}"
  ) @block.outer

; classes
(struct_declaration
  .
  (identifier)
  .
  (tag)*
  .
  "{"
  .
  (_) @_first @class.inner._start @_last @class.inner._end
  (_)?
  "," @_last @class.inner._end
  .
  "}"
  ) @class.outer

(union_declaration
  .
  (identifier)
  .
  (tag)*
  .
  "{"
  .
  (_) @_first @class.inner._start @_last @class.inner._end
  (_)?
  "," @_last @class.inner._end
  .
  "}"
  ) @class.outer

(enum_declaration
  .
  (identifier)
  .
  (tag)*
  .
  "{"
  .
  (_) @_first @class.inner._start @_last @class.inner._end
  (_)?
  "," @_last @class.inner._end
  .
  "}"
  ) @class.outer

; comments
(comment) @comment.outer

(block_comment) @comment.outer

; assignment
; works also for multiple targets in lhs. ex. 'res, ok := get_res()'
((assignment_statement
  .
  (_) @_first @assignment.lhs._start
  (_) @_prelast @assignment.lhs._end
  .
  (_) @assignment.rhs @assignment.inner .)
  ) @assignment.outer

; attribute
(attribute
  (_) @attribute.inner) @attribute.outer

; number
(number) @number.inner

; parameters
((parameters
  ","  @parameter.outer._start
  .
  (parameter) @parameter.inner @parameter.outer._end)
  )

((parameters
  .
  (parameter) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((call_expression
  function: (_)
  ","  @parameter.outer._start
  .
  argument: (_) @parameter.inner @parameter.outer._end)
  )

((call_expression
  function: (_)
  .
  argument: (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

