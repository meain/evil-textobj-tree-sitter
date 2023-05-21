(function_declaration (function_body) @function.inner) @function.outer
(comment) @comment.inner
(comment)+ @comment.outer
(class_declaration (aggregate_body) @class.inner) @class.outer
(interface_declaration (aggregate_body) @class.inner) @class.outer
(struct_declaration (aggregate_body) @class.inner) @class.outer
(unittest_declaration (block_statement) @test.inner) @test.outer
(parameter) @parameter.inner
(template_parameter) @parameter.inner
