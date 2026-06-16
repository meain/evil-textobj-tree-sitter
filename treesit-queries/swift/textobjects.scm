(class_declaration
  body: (_) @class.inner) @class.outer

(protocol_declaration
  body: (_) @class.inner) @class.outer

(function_declaration
  body: (_) @function.inner) @function.outer

(init_declaration
  body: (_) @function.inner) @function.outer

(deinit_declaration
  body: (_) @function.inner) @function.outer

(subscript_declaration
  (computed_property) @function.inner) @function.outer

; Closures: the body lives in a `statements` child (the `{ … in }` signature is
; separate), so `*.inside` is the body alone; optional so empty closures match.
(lambda_literal
  (statements)? @function.inner) @function.outer

(parameter
  (_) @parameter.inner) @parameter.outer

(lambda_parameter
  (_) @parameter.inner) @parameter.outer

(value_argument
  (_) @parameter.inner) @parameter.outer

[
  (comment)
  (multiline_comment)
] @comment.inner

(comment)+ @comment.outer

(multiline_comment) @comment.outer
