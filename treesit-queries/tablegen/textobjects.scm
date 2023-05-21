(class
  body: (_) @class.inner) @class.outer

(multiclass
  body: (_) @class.inner) @class.outer

(_ argument: _ @parameter.inner)

[
  (comment)
  (multiline_comment)
] @comment.inner

(comment)+ @comment.outer

(multiline_comment) @comment.outer
