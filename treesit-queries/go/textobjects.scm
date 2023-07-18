(function_declaration
  body: (block)? @function.inner) @function.outer

(func_literal
  (_)? @function.inner) @function.outer

(method_declaration
  body: (block)? @function.inner) @function.outer

;; struct and interface declaration as class textobject?
(type_declaration
  (type_spec (type_identifier) (struct_type (field_declaration_list (_)?) @class.inner))) @class.outer

(type_declaration
  (type_spec (type_identifier) (interface_type (method_spec)+ @class.inner))) @class.outer

(type_parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer

((function_declaration
   name: (identifier) @_name
   body: (block)? @test.inner) @test.outer
 (#match "^Test" @_name))
