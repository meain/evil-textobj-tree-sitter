; @functions
 ((method . name: (identifier) (method_parameters)? . (_) @function.inner @function.inner._start (_)? @function.end @function.inner._end .)
   ) @function.outer
 ((singleton_method . name: (identifier) (method_parameters)? . (_) @function.inner @function.inner._start (_)? @function.end @function.inner._end .)
   ) @function.outer

; @blocks
((block (block_parameters)? . (_) @block.inner @block.inner._start (_)? @block.inner.end @block.inner._end .)
  ) @block.outer
((do_block (block_parameters)? . (_) @block.inner @block.inner._start (_)? @block.inner.end @block.inner._end .)
  ) @block.outer

; @classes
(
  (class . name: (constant) (superclass) . (_) @class.inner @class.inner._start (_)? @class.end @class.inner._end .)
  
 ) @class.outer
(
  (class . name: (constant) !superclass . (_) @class.inner @class.inner._start (_)? @class.end @class.inner._end .)
  
 ) @class.outer

((module name: (constant) . (_) @class.inner @class.inner._start (_)? @class.inner.end @class.inner._end .)
 ) @class.outer

((singleton_class value: (self) . (_) @class.inner @class.inner._start (_)? @class.inner.end @class.inner._end .)
 ) @class.outer

; @parameters
(block_parameters (_) @parameter.inner)
(method_parameters (_) @parameter.inner)
(lambda_parameters (_) @parameter.inner)
(argument_list (_) @parameter.inner)

[
  (block_parameters)
  (method_parameters)
  (lambda_parameters)
  (argument_list)
] @parameter.outer

