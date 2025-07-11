; inner function textobject
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

; inner function literals
(func_literal
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

; method as inner function textobject
(method_declaration
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

; outer function textobject
(function_declaration) @function.outer

; outer function literals
(func_literal
  (_)?) @function.outer

; method as outer function textobject
(method_declaration
  body: (block)?) @function.outer

; struct and interface declaration as class textobject?
(type_declaration
  (type_spec
    (type_identifier)
    (struct_type))) @class.outer

(type_declaration
  (type_spec
    (type_identifier)
    (struct_type
      (field_declaration_list
        "{"
        .
        _  @class.inner._start  @class.inner._end
        _?  @class.inner._end
        .
        "}"
        ))))

(type_declaration
  (type_spec
    (type_identifier)
    (interface_type))) @class.outer

(type_declaration
  (type_spec
    (type_identifier)
    (interface_type
      "{"
      .
      _  @class.inner._start  @class.inner._end
      _?  @class.inner._end
      .
      "}"
      )))

; struct literals as class textobject
(composite_literal
  (literal_value)) @class.outer

(composite_literal
  (literal_value
    "{"
    .
    _  @class.inner._start  @class.inner._end
    _?  @class.inner._end
    .
    "}")
  )

; conditionals
(if_statement
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block
    "{"
    .
    _  @conditional.inner._start  @conditional.inner._end
    _?  @conditional.inner._end
    .
    "}"
    ))

(if_statement
  condition: (_) @conditional.inner)

; loops
(for_statement) @loop.outer

(for_statement
  body: (block
    .
    "{"
    .
    _  @loop.inner._start  @loop.inner._end
    _?  @loop.inner._end
    .
    "}"
    ))

; blocks
(_
  (block) @block.inner) @block.outer

; statements
(block
  (_) @statement.outer)

; comments
(comment) @comment.outer

; calls
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

; parameters
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

(parameter_declaration
  name: (identifier)
  type: (_)) @parameter.inner

(parameter_declaration
  name: (identifier)
  type: (_)) @parameter.inner

(parameter_list
  ","  @parameter.outer._start
  .
  (variadic_parameter_declaration) @parameter.inner @parameter.outer._end
  )

; arguments
(argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; assignments
(short_var_declaration
  left: (_) @assignment.lhs
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

(assignment_statement
  left: (_) @assignment.lhs
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

(var_declaration
  (var_spec
    name: (_) @assignment.lhs
    value: (_) @assignment.rhs @assignment.inner)) @assignment.outer

(var_declaration
  (var_spec
    name: (_) @assignment.inner
    type: (_))) @assignment.outer

(const_declaration
  (const_spec
    name: (_) @assignment.lhs
    value: (_) @assignment.rhs @assignment.inner)) @assignment.outer

(const_declaration
  (const_spec
    name: (_) @assignment.inner
    type: (_))) @assignment.outer

