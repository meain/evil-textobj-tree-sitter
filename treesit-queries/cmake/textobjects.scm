[
  (macro_def)
  (function_def)
] @function.outer

(argument) @parameter.inner

[
  (bracket_comment)
  (line_comment)
] @comment.inner

(line_comment)+ @comment.outer

(bracket_comment) @comment.outer