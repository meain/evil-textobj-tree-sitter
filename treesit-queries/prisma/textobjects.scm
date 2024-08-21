(model_declaration
  ((statement_block) @class.inner)) @class.outer

(call_expression
  (arguments (_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(column_declaration) @entry.outer

(array (_) @entry.outer)

(assignment_expression
  (_) @entry.inner) @entry.outer

(developer_comment) @comment.inner

(developer_comment)+ @comment.outer

