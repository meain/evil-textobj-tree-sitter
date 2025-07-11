[
  (integer)
  (float)
] @number.inner

(table
  (pair) @parameter.inner @parameter.outer)

((inline_table
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((inline_table
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((array
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((array
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(comment) @comment.outer

