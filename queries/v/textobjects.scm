; assignment
[
  (var_declaration
    var_list: (_) @assignment.lhs
    expression_list: (_)* @assignment.rhs)
  (assignment_statement
    left: (_) @assignment.lhs
    right: (_)* @assignment.rhs)
]

[
  (var_declaration
    var_list: (_) @assignment.inner)
  (assignment_statement
    left: (_) @assignment.inner)
]

[
  (var_declaration
    expression_list: (_) @assignment.inner)
  (assignment_statement
    right: (_) @assignment.inner)
]

; block
(_
  (block
    .
    "{"
    .
    (_)  @block.inner._start  @block.inner._end
    (_)?  @block.inner._end
    .
    "}")
  ) @block.outer

; call
(call_expression) @call.outer

(call_expression
  arguments: (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

; class: structs
(struct_declaration
  ("{"
    .
    (_)  @class.inner._start  @class.inner._end
    (_)?  @class.inner._end
    .
    "}"
    ))

(struct_declaration) @class.outer

; comment
; leave space after comment marker if there is one
((line_comment) @comment.inner @comment.outer
  (#offset! @comment.inner 0 3 0)
  (#match? @comment.outer "// .*"))

; else remove everything accept comment marker
((line_comment) @comment.inner @comment.outer
  (#offset! @comment.inner 0 2 0))

(block_comment) @comment.inner @comment.outer

; conditional
(if_expression
  block: (block
    .
    "{"
    .
    (_)  @conditional.inner._start  @conditional.inner._end
    (_)?  @conditional.inner._end
    .
    "}"
    )?) @conditional.outer

; function
(function_declaration
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(function_declaration) @function.outer

; loop
(for_statement
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )?) @loop.outer

[
  (int_literal)
  (float_literal)
] @number.inner

; parameter
(parameter_list
  ","  @parameter.outer._start
  .
  (parameter_declaration) @parameter.inner @parameter.outer._end
  )

(parameter_list
  .
  (parameter_declaration) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; return
(return_statement
  (_)* @return.inner) @return.outer

; statements
(block
  (_) @statement.outer)

