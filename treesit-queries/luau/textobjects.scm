(fn_stmt
  body: (_)? @function.inner) @function.outer

(local_fn_stmt
  body: (_)? @function.inner) @function.outer

(anon_fn
  body: (_)? @function.inner) @function.outer

(param
  ((name) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arglist
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
