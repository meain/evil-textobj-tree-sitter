; "Classes"
(variable_declaration
  (struct_declaration)) @class.outer

(variable_declaration
  (struct_declaration
    "struct"
    "{"
    .
    _  @class.inner._start  @class.inner._end
    _?  @class.inner._end
    .
    "}")
  )

; functions
(function_declaration) @function.outer

(function_declaration
  body: (block
    .
    "{"
    .
    _  @function.inner._start  @function.inner._end
    _?  @function.inner._end
    .
    "}")
  )

; loops
(for_statement) @loop.outer

(for_statement
  body: (_) @loop.inner)

(while_statement) @loop.outer

(while_statement
  body: (_) @loop.inner)

; blocks
(block) @block.outer

(block
  "{"
  .
  _  @block.inner._start  @block.inner._end
  _?  @block.inner._end
  .
  "}"
  )

; statements
(statement) @statement.outer

; parameters
(parameters
  ","  @parameter.outer._start
  .
  (parameter) @parameter.inner @parameter.outer._end
  )

(parameters
  .
  (parameter) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; arguments
(call_expression
  function: (_)
  "("
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  ")"
  )

(call_expression
  function: (_)
  "("
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  ")"
  )

; comments
(comment) @comment.outer

; conditionals
(if_statement) @conditional.outer

(if_statement
  condition: (_) @conditional.inner)

(if_statement
  body: (_) @conditional.inner)

(switch_expression) @conditional.outer

(switch_expression
  "("
  (_) @conditional.inner
  ")")

(switch_expression
  "{"
  .
  _  @conditional.inner._start
  _?  @conditional.inner._end
  .
  "}"
  )

(while_statement
  condition: (_) @conditional.inner)

; calls
(call_expression) @call.outer

(call_expression
  "("
  .
  _  @call.inner._start
  _?  @call.inner._end
  .
  ")"
  )

