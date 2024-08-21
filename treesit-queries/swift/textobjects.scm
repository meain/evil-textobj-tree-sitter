(class_declaration
  body: (_) @class.inner) @class.outer

(protocol_declaration
  body: (_) @class.inner) @class.outer

(function_declaration
  body: (_) @function.inner) @function.outer

(parameter
  (_) @parameter.inner) @parameter.outer

(lambda_parameter
  (_) @parameter.inner) @parameter.outer

[
  (comment)
  (multiline_comment)
] @comment.inner

(comment)+ @comment.outer

(multiline_comment) @comment.outer
