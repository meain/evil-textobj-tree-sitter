(let
  pattern: (call)
  value: (_) @function.inner) @function.outer

(call
  (group
    ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer))

(lambda
  pattern: 
    (group
      ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)
  value: (_) @function.inner) @function.outer

(group
  [
    (tagged (_) @entry.inner)
    (_)
  ] @entry.outer)

(comment) @comment.inner

(comment)+ @comment.outer
