(comment) @comment.inner

[
  (adt)
  (type_alias)
  (newtype)
] @class.outer

((signature)? (function rhs:(_) @function.inner)) @function.outer 
(exp_lambda) @function.outer

(adt (type_variable) @parameter.inner)
(patterns (_) @parameter.inner)
