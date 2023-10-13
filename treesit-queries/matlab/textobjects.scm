(arguments ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)
(function_arguments ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(lambda expression: (_) @function.inner) @function.outer
(function_definition (block) @function.inner) @function.outer

(class_definition) @class.inner @class.outer

(comment) @comment.inner @comment.outer
