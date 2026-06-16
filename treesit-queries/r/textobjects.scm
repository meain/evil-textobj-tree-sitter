; Comments

(comment) @comment.inner
(comment)+ @comment.outer

; Functions

(function_definition body: (_) @function.inner) @function.outer

; Parameters

(parameters
  ((_) @parameter.inner . (comma)? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . (comma)? @parameter.outer) @parameter.outer)
