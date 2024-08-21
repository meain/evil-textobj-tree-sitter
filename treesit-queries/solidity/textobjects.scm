(function_definition
  body: (_) @function.inner) @function.outer

(constructor_definition
  body: (_) @function.inner) @function.outer

(fallback_receive_definition
  body: (_) @function.inner) @function.outer

(yul_function_definition
  (yul_block) @function.inner) @function.outer

(function_definition 
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(constructor_definition 
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(return_type_definition 
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(modifier_definition 
  ((parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(event_definition 
  ((event_parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(error_declaration 
  ((error_parameter) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(call_argument
  ((call_struct_argument) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(call_expression
  ((call_argument) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(variable_declaration_tuple
  ((variable_declaration) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(emit_statement
  ((call_argument) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(revert_arguments
  ((call_argument) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(struct_declaration
  body: (_) @class.inner) @class.outer

(enum_declaration
  body: (_) @class.inner) @class.outer

(comment) @comment.inner

(comment)+ @comment.outer
