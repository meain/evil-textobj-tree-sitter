(function_definition
  body: (_) @function.inner) @function.outer

(command
  argument: (_) @parameter.inner)

(comment) @comment.inner

(comment)+ @comment.outer

(array
  (_) @entry.outer)
