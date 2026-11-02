(knot_block (knot function: _) . _+ @function.inner) @function.outer
(knot_block (knot !function) . _+ @class.inner) @class.outer
(stitch_block (stitch) . _+ @class.inner) @class.outer


(params ((param) @parameter.inner . ","? @parameter.outer) @parameter.outer)
(args ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(line_comment) @comment.inner
(line_comment)+ @comment.outer

(block_comment) @comment.inner @comment.outer

(((list_value_def) @entry.inner ) . ","? @entry.outer) @entry.outer

