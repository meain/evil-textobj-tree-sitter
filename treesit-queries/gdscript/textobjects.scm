
(class_definition
  (body) @class.inner) @class.outer

(function_definition
  (body) @function.inner) @function.outer

(lambda (body) @function.inner) @function.outer

(parameters 
  [
    (identifier)
    (typed_parameter)
    (default_parameter)    
    (typed_default_parameter)  
  ] @parameter.inner @parameter.outer)

(arguments (_expression) @parameter.inner @parameter.outer)

[
  (const_statement)
  (variable_statement)
  (pair)
  (enumerator)
] @entry.outer

(comment) @comment.inner
(comment)+ @comment.outer
