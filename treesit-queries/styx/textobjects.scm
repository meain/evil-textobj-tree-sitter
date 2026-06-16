[(line_comment) (doc_comment)] @comment.inner

(line_comment)+ @comment.outer
(doc_comment)+ @comment.outer

(entry value: (_) @entry.inner) @entry.outer
