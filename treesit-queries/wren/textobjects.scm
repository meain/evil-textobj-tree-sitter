(class_definition
  (class_body) @class.inner) @class.outer

(call_expression
  (call_body
    (_) @function.inner) @function.outer)

(method_definition
  body: (_) @function.inner) @function.outer

(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
