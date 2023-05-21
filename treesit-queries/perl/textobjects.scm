(function_definition 
  (identifier) (_) @function.inner) @function.outer

(anonymous_function 
  (_) @function.inner) @function.outer

(argument 
  (_) @parameter.inner)

[
  (comments)
  (pod_statement)
] @comment.inner

(comments)+ @comment.outer

(pod_statement) @comment.outer
