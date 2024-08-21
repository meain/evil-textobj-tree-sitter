(comment) @comment.inner
(comment)+ @comment.outer

(function_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(attribute
  (_) @entry.inner) @entry.outer

(tuple
  (_) @entry.outer)
