(function_definition
  body: (_) @function.inner) @function.outer

(function_declaration
  body: (_) @function.inner) @function.outer

(parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
