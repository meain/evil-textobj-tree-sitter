(condition_declaration
  body: (_) @function.inner) @function.outer

(param 
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
