(function_definition
  body: (_) @function.inner) @function.outer

(struct_specifier
  body: (_) @class.inner) @class.outer

(interface_specifier
  body: (_) @class.inner) @class.outer

(enum_specifier
  body: (_) @class.inner) @class.outer

(union_specifier
  body: (_) @class.inner) @class.outer

(parameter_list 
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer

(enumerator
  (_) @entry.inner) @entry.outer

(initializer_list
  (_) @entry.outer)
