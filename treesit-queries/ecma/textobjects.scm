(function_declaration
  body: (_) @function.inner) @function.outer

(function
  body: (_) @function.inner) @function.outer

(arrow_function
  body: (_) @function.inner) @function.outer

(method_definition
  body: (_) @function.inner) @function.outer

(generator_function_declaration
  body: (_) @function.inner) @function.outer

(class_declaration
  body: (class_body) @class.inner) @class.outer

(class
  (class_body) @class.inner) @class.outer

(export_statement
  declaration: [
    (function_declaration) @function.outer
    (class_declaration) @class.outer 
  ])

(formal_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
