(class
  body: (_) @class.inner) @class.outer

(trait
  body: (_) @class.inner) @class.outer

(method
  body: (_) @function.inner) @function.outer

(reopen_class
  body: (_) @class.inner) @class.outer

(implement_trait
  body: (_) @class.inner) @class.outer

(external_function
  body: (_) @function.inner) @function.outer

(closure
  body: (_) @function.inner) @function.outer

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(line_comment) @comment.inner

(line_comment)+ @comment.outer

(array (_) @entry.outer)

(tuple (_) @entry.outer)

(tuple_pattern (_) @entry.outer)

(define_field (_) @entry.inner) @entry.outer
