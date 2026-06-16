; Rule sets and their declaration blocks
(rule_set) @function.outer
(rule_set
  (block) @function.inner)

(keyframe_block_list) @function.outer
(keyframe_block
  (block) @function.inner)

; At-rules with a body (e.g. @media, @supports)
(media_statement) @class.outer
(media_statement
  (block) @class.inner)

; Declarations as key/value entries
(declaration) @entry.outer
(declaration
  ":"
  (_) @entry.inner)

(comment) @comment.inner
(comment)+ @comment.outer
