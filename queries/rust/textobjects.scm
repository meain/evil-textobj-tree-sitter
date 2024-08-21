; functions
(function_signature_item) @function.outer

(function_item) @function.outer

(function_item
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

; quantifies as class(es)
(struct_item) @class.outer

(struct_item
  body: (field_declaration_list
    .
    "{"
    .
    (_)  @class.inner._start
    [
      (_)
      ","
    ]?  @class.inner._end
    .
    "}"
    ))

(enum_item) @class.outer

(enum_item
  body: (enum_variant_list
    .
    "{"
    .
    (_)  @class.inner._start
    [
      (_)
      ","
    ]?  @class.inner._end
    .
    "}"
    ))

(union_item) @class.outer

(union_item
  body: (field_declaration_list
    .
    "{"
    .
    (_)  @class.inner._start
    [
      (_)
      ","
    ]?  @class.inner._end
    .
    "}"
    ))

(trait_item) @class.outer

(trait_item
  body: (declaration_list
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    (_)?  @class.inner._end
    .
    "}"
    ))

(impl_item) @class.outer

(impl_item
  body: (declaration_list
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    (_)?  @class.inner._end
    .
    "}"
    ))

(mod_item) @class.outer

(mod_item
  body: (declaration_list
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    (_)?  @class.inner._end
    .
    "}"
    ))

; conditionals
(if_expression
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if_expression
  alternative: (else_clause
    (block) @conditional.inner))

(if_expression
  condition: (_) @conditional.inner)

(if_expression
  consequence: (block) @conditional.inner)

(match_arm
  (_)) @conditional.inner

(match_expression) @conditional.outer

; loops
(loop_expression
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start
    [
      (_)
      ","
    ]?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(while_expression
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start
    [
      (_)
      ","
    ]?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(for_expression
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start
    [
      (_)
      ","
    ]?  @loop.inner._end
    .
    "}"
    )) @loop.outer

; blocks
(_
  (block) @block.inner) @block.outer

(unsafe_block
  (_)? @block.inner) @block.outer

; calls
(macro_invocation) @call.outer

(macro_invocation
  (token_tree
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(call_expression) @call.outer

(call_expression
  arguments: (arguments
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

; returns
(return_expression
  (_)? @return.inner) @return.outer

; statements
(block
  (_) @statement.outer)

; comments
(line_comment) @comment.outer

(block_comment) @comment.outer

; parameter
((parameters
  ","  @parameter.outer._start
  .
  (self_parameter) @parameter.inner @parameter.outer._end)
  )

((parameters
  .
  (self_parameter) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

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

((parameters
  ","  @parameter.outer._start
  .
  (type_identifier) @parameter.inner @parameter.outer._end)
  )

((parameters
  .
  (type_identifier) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((type_parameters
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((type_parameters
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((tuple_pattern
  ","  @parameter.outer._start
  .
  (identifier) @parameter.inner @parameter.outer._end)
  )

((tuple_pattern
  .
  (identifier) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((tuple_struct_pattern
  ","  @parameter.outer._start
  .
  (identifier) @parameter.inner @parameter.outer._end)
  )

((tuple_struct_pattern
  .
  (identifier) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(tuple_expression
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(tuple_expression
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

((tuple_type
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((tuple_type
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(struct_item
  body: (field_declaration_list
    ","  @parameter.outer._start
    .
    (_) @parameter.inner @parameter.outer._end
    ))

(struct_item
  body: (field_declaration_list
    .
    (_) @parameter.inner @parameter.outer._start
    .
    ","?  @parameter.outer._end
    ))

(struct_expression
  body: (field_initializer_list
    ","  @parameter.outer._start
    .
    (_) @parameter.inner @parameter.outer._end
    ))

(struct_expression
  body: (field_initializer_list
    .
    (_) @parameter.inner @parameter.outer._start
    .
    ","?  @parameter.outer._end
    ))

((closure_parameters
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((closure_parameters
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((type_arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((type_arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((token_tree
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((token_tree
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(scoped_use_list
  list: (use_list
    ","  @parameter.outer._start
    .
    (_) @parameter.inner @parameter.outer._end
    ))

(scoped_use_list
  list: (use_list
    .
    (_) @parameter.inner @parameter.outer._start
    .
    ","?  @parameter.outer._end
    ))

[
  (integer_literal)
  (float_literal)
] @number.inner

(let_declaration
  pattern: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(let_declaration
  pattern: (_) @assignment.inner)

(assignment_expression
  left: (_) @assignment.lhs
  right: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assignment_expression
  left: (_) @assignment.inner)

