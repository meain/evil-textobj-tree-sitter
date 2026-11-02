; Specify how to navigate around logical blocks in code

(assert_parameters
  ((_) @parameter.inner . ","? @parameter.outer)) @parameter.outer

(function
  (expression) @function.inner) @function.outer

(function_decl_parameters
  ((_) @parameter.inner . ","? @parameter.outer)) @parameter.outer

(recipe
  (recipe_body) @function.inner) @function.outer

(recipe_parameters
  ((_) @parameter.inner . ","? @parameter.outer)) @parameter.outer

(recipe_dependency
  (_) @parameter.inner) @parameter.outer

(function_call
  (function_call_parameters
    ((_) @parameter.inner . ","? @parameter.outer)) @parameter.outer) @function.outer

(comment) @comment.outer
