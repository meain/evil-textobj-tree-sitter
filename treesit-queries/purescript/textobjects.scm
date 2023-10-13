(comment) @comment.inner

[
  (data)
  (type)
  (newtype)
] @class.outer

((signature)? (function rhs:(_) @function.inner)) @function.outer 
(exp_lambda) @function.outer

(data (type_variable) @parameter.inner)
(patterns (_) @parameter.inner)
