; Functions/constructors/predicates in Domain
(constructor_decl) @function.outer

(function_decl) @function.outer

(predicate_decl) @function.outer

; Parameters
(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; Arguments
(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; Comments
(comment) @comment.inner
(comment) @comment.outer
