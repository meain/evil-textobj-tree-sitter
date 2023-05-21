(method_declaration
  body: (_) @function.inner) @function.outer

(interface_declaration
  body: (_) @class.inner) @class.outer

(class_declaration
  body: (_) @class.inner) @class.outer

(record_declaration
  body: (_) @class.inner) @class.outer

(enum_declaration
  body: (_) @class.inner) @class.outer

(formal_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

[
  (line_comment)
  (block_comment)
] @comment.inner

(line_comment)+ @comment.outer

(block_comment) @comment.outer
