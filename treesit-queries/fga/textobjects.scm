(type_declaration
  (relations) @class.inner) @class.outer

(condition_declaration
  body: (_) @function.inner) @function.outer

(relations
  (definition) @entry.inner) @entry.outer

(param 
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner

(comment)+ @comment.outer
