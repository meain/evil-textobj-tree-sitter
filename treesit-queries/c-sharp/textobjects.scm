[
  (class_declaration body: (_) @class.inner)
  (struct_declaration body: (_) @class.inner)
  (interface_declaration body: (_) @class.inner)
  (enum_declaration body: (_) @class.inner)
  (delegate_declaration)
  (record_declaration body: (_) @class.inner)
  (record_struct_declaration body: (_) @class.inner)
] @class.outer

(constructor_declaration body: (_) @function.inner) @function.outer

(destructor_declaration body: (_) @function.inner) @function.outer

(method_declaration body: (_) @function.inner) @function.outer

(property_declaration (_) @function.inner) @function.outer

(parameter (_) @parameter.inner) @parameter.outer

(comment)+ @comment.outer
