(function_declaration
  body: (statement_block)) @function.outer

(function_expression
  body: (statement_block)) @function.outer

(function_declaration
  body: (statement_block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(function_expression
  body: (statement_block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(export_statement
  (function_declaration)) @function.outer

(arrow_function
  body: (_) @function.inner) @function.outer

(arrow_function
  body: (statement_block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(method_definition
  body: (statement_block)) @function.outer

(method_definition
  body: (statement_block
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(class_declaration
  body: (class_body) @class.inner) @class.outer

(export_statement
  (class_declaration)) @class.outer

(for_in_statement
  body: (statement_block
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(for_statement
  body: (statement_block
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(while_statement
  body: (statement_block
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(do_statement
  body: (statement_block
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(if_statement
  consequence: (statement_block
    .
    "{"
    .
    (_)  @conditional.inner._start  @conditional.inner._end
    (_)?  @conditional.inner._end
    .
    "}"
    )) @conditional.outer

(if_statement
  alternative: (else_clause
    (statement_block
      .
      "{"
      .
      (_)  @conditional.inner._start  @conditional.inner._end
      (_)?  @conditional.inner._end
      .
      "}"
      ))) @conditional.outer

(if_statement) @conditional.outer

(switch_statement
  body: (_)? @conditional.inner) @conditional.outer

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

((new_expression
  constructor: (identifier) @_cons
  arguments: (arguments
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")") @_args)
  
  )

; blocks
(_
  (statement_block) @block.inner) @block.outer

; parameters
; function ({ x }) ...
; function ([ x ]) ...
; function (v = default_value)
(formal_parameters
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(formal_parameters
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; If the array/object pattern is the first parameter, treat its elements as the argument list
(formal_parameters
  .
  (_
    [
      (object_pattern
        ","  @parameter.outer._start
        .
        (_) @parameter.inner @parameter.outer._end)
      (array_pattern
        ","  @parameter.outer._start
        .
        (_) @parameter.inner @parameter.outer._end)
    ])
  )

(formal_parameters
  .
  (_
    [
      (object_pattern
        .
        (_) @parameter.inner @parameter.outer._start
        .
        ","?  @parameter.outer._end)
      (array_pattern
        .
        (_) @parameter.inner @parameter.outer._start
        .
        ","?  @parameter.outer._end)
    ])
  )

; arguments
(arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; comment
(comment) @comment.outer

; regex
(regex
  (regex_pattern) @regex.inner) @regex.outer

; number
(number) @number.inner

(variable_declarator
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(variable_declarator
  name: (_) @assignment.inner)

(object
  (pair
    key: (_) @assignment.lhs
    value: (_) @assignment.inner @assignment.rhs) @assignment.outer)

