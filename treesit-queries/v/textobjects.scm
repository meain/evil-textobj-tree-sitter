(function_declaration
  body: (block)? @function.inner) @function.outer

((function_declaration
   name: (identifier) @_name
   body: (block)? @test.inner) @test.outer
 (#match "^test" @_name))

(fn_literal
  body: (block)? @function.inner) @function.outer

(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(call_expression
  (argument_list
    ((_) @parameter.inner) @parameter.outer))

(struct_declaration
  (struct_field_declaration_list) @class.inner) @class.outer

(struct_field_declaration_list
  ((_) @parameter.inner) @parameter.outer)

(comment) @comment.inner
(comment)+ @comment.outer

