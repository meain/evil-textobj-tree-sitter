(comment) @comment.inner
(comment)+ @comment.outer

(formals
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(function_expression
  body: (_) @function.inner) @function.outer

(binding
  (_) @entry.inner) @entry.outer

