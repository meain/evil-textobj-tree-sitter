(class_declaration
  body: (_) @class.inner) @class.outer

(interface_declaration
  body: (_) @class.inner) @class.outer

(trait_declaration
  body: (_) @class.inner) @class.outer

(enum_declaration
  body: (_) @class.inner) @class.outer

(function_definition
  body: (_) @function.inner) @function.outer

(method_declaration
  body: (_) @function.inner) @function.outer

(arrow_function 
  body: (_) @function.inner) @function.outer
  
(anonymous_function_creation_expression
  body: (_) @function.inner) @function.outer

(anonymous_function_use_clause
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(formal_parameters
  ([
    (simple_parameter)
    (variadic_parameter)
    (property_promotion_parameter)
  ] @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
