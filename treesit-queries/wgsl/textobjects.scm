(function_declaration
  body: (_) @function.inner) @function.outer

(struct_declaration) @class.outer

[
  (struct_member)
  (parameter)
  (variable_declaration)
] @parameter.outer

(comment) @comment.inner

(comment)+ @comment.outer
