; Functions - capture both definition and body
(function_definition
  body: (_) @function.inner) @function.outer

; Function parameters in definitions
(function_parameter_list
  (function_parameter_list_item) @parameter.inner)

; Function call arguments
(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; Comments
(comment) @comment.inner
(comment)+ @comment.outer

; Arrays
(array
  (_) @entry.outer)

; Main Block looks like a function
(main_block
  (block) @function.inner) @function.outer
