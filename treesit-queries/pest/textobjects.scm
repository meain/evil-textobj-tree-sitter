(grammar_rule (_) @class.inner) @class.outer
(term (_) @entry.inner) @entry.outer

(line_comment) @comment.inner
(line_comment)+ @comment.outer

(block_comment) @comment.inner
(block_comment)+ @comment.outer
