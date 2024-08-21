; Classes

(enum_statement
  (enum_body) @class.inner) @class.outer

(model_statement
  (model_expression) @class.inner) @class.outer

(union_statement
  (union_body) @class.inner) @class.outer

; Interfaces

(interface_statement
  (interface_body
    (interface_member) @function.outer) @class.inner) @class.outer

; Comments

[
  (single_line_comment)
  (multi_line_comment)
] @comment.inner

[
  (single_line_comment)
  (multi_line_comment)
]+ @comment.outer

; Functions

[
  (decorator)
  (decorator_declaration_statement)
  (function_declaration_statement)
  (operation_statement)
] @function.outer

(function_parameter_list
  (function_parameter)? @parameter.inner)* @function.inner

(decorator_arguments
  (expression_list
    (_) @parameter.inner)*) @function.inner

(operation_arguments
  (model_property)? @parameter.inner)* @function.inner

(template_parameters
  (template_parameter_list
    (template_parameter) @parameter.inner)) @function.inner
