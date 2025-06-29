(function_definition
  body: (_) @function.inner) @function.outer

(alias_declaration
  body: (_) @function.inner) @function.outer

(enum_struct_method
  body: (_) @function.inner) @function.outer

(methodmap_method
  body: (_) @function.inner) @function.outer

(methodmap_method_constructor
  body: (_) @function.inner) @function.outer

(methodmap_method_destructor
  body: (_) @function.inner) @function.outer

(methodmap_property_method
  body: (_) @function.inner) @function.outer

(enum_struct) @class.outer

(methodmap) @class.outer

(parameter_declarations 
  ((parameter_declaration) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.outer
