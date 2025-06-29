(term_declaration) @function.outer

(type_declaration) @class.inner
(record) @class.inner

(comment) @comment.inner
(comment)+ @comment.outer

(doc_block) @comment.outer

(literal_list) @entry.outer

(parenthesized_or_tuple_pattern) @entry.outer

(pattern) @entry.outer
