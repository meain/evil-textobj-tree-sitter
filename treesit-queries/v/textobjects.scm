(function_declaration
  body: (block)? @function.inner) @function.outer

((function_declaration
   name: (identifier) @_name
   body: (block)? @test.inner) @test.outer
 (#match "^test" @_name))

(function_literal
  body: (block)? @function.inner) @function.outer

(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(call_expression
  (argument_list
    ((_) @parameter.inner) @parameter.outer))

(struct_declaration
    (struct_field_declaration) @class.inner) @class.outer

(struct_field_declaration
  ((_) @parameter.inner) @parameter.outer)

[(line_comment) (block_comment)] @comment.inner
[(line_comment)+ (block_comment)+] @comment.outer

