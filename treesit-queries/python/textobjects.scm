(function_definition
  body: (block)? @function.inner) @function.outer

(class_definition
  body: (block)? @class.inner) @class.outer

(parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)
  
(lambda_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer

((function_definition
   name: (identifier) @_name
   body: (block)? @test.inner) @test.outer
 (#match "^test_" @_name))

(for_statement
 body: (_) @loop.inner) @loop.outer

(while_statement
 body: (_) @loop.inner) @loop.outer

(if_statement
 consequence: (_) @conditional.inner) @conditional.outer
