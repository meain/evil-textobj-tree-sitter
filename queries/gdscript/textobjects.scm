(function_definition
  body: (_) @function.inner) @function.outer

(constructor_definition
  body: (_) @function.inner) @function.outer

(class_definition
  body: (_) @class.inner) @class.outer

(if_statement
  body: (_) @conditional.inner) @conditional.outer

(if_statement
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if_statement
  condition: (_) @conditional.inner)

[
  (for_statement)
  (while_statement)
] @loop.outer

(while_statement
  body: (_) @loop.inner)

(for_statement
  body: (_) @loop.inner)

(comment) @comment.outer

(parameters
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(parameters
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

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

(array
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(array
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

