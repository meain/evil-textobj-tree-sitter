(function_decl
  body: (_) @function.inner) @function.outer

(struct_decl
  body: (_) @class.inner) @class.outer

(param_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(template_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

[
  (line_comment)
  (block_comment)
] @comment.inner
  
(line_comment)+ @comment.outer

(block_comment) @comment.outer
