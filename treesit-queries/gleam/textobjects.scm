(function
  parameters: (function_parameters (function_parameter)? @parameter.inner)
  body: (function_body) @function.inner) @function.outer

(anonymous_function
  body: (function_body) @function.inner) @function.outer

((function
   name: (identifier) @_name
   body: (function_body) @test.inner) @test.outer
 (#match "_test$" @_name))
