(function_declaration) @function.outer

(function_declaration
  body: (_) @function.inner)

(function_declaration
  (fndec_attrs
    (fndec_attr "@test"))) @test.outer

(function_declaration
  (fndec_attrs
    (fndec_attr "@test"))
  body: (_) @test.inner)

(parameter) @parameter.outer

(switch_case) @parameter.outer

(comment) @comment.inner

(comment)+ @comment.outer

(type_declaration) @class.outer
