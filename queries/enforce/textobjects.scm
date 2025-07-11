[
  (comment_line)
  (comment_block)
  (doc_line)
  (doc_block)
] @comment.outer

[
  (literal_int)
  (literal_float)
] @number.inner

; TODO: capture inside braces
(decl_class
  body: (_) @class.inner) @class.outer

(decl_method
  body: (_) @function.inner) @function.outer

(for
  body: (_) @loop.inner) @loop.outer

(while
  body: (_) @loop.inner) @loop.outer

(return
  (_)? @return.inner) @return.outer

; blocks
(block) @block.outer

(invokation) @call.outer

(formal_parameters
  ","  @parameter.outer._start
  .
  (formal_parameter) @parameter.inner @parameter.outer._end
  )

(formal_parameters
  .
  (formal_parameter) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(actual_parameters
  ","  @parameter.outer._start
  .
  (actual_parameter) @parameter.inner @parameter.outer._end
  )

(actual_parameters
  .
  (actual_parameter) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

