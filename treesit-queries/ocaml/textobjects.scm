; Value/function definitions
(value_definition) @function.outer
(value_definition
  (let_binding
    body: (_) @function.inner))

(fun_expression
  body: (_) @function.inner) @function.outer

(function_expression) @function.outer

(method_definition
  body: (_) @function.inner) @function.outer

; Types and modules
(type_definition) @class.outer
(type_definition
  (type_binding
    body: (_) @class.inner))

(module_definition) @class.outer
(module_definition
  (module_binding
    body: (_) @class.inner))

; Parameters
(parameter) @parameter.outer
(parameter
  pattern: (_) @parameter.inner)

(comment) @comment.inner
(comment)+ @comment.outer
