(method_declaration
  (block) @function.inner) @function.outer

(creation_method_declaration
  (block) @function.inner) @function.outer

(method_declaration
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

[
  (class_declaration)
  (struct_declaration)
  (interface_declaration)
] @class.outer

(type_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(creation_method_declaration
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(method_call_expression
  ((argument) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
