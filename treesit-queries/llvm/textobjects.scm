(define
  body: (_) @function.inner) @function.outer

(struct_type
  (struct_body) @class.inner) @class.outer

(packed_struct_type
  (struct_body) @class.inner) @class.outer

(array_type
  (array_vector_body) @class.inner) @class.outer

(vector_type
  (array_vector_body) @class.inner) @class.outer

(argument) @parameter.inner

(comment) @comment.inner

(comment)+ @comment.outer
