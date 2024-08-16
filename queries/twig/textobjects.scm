; comments
(comment) @comment.outer

; statement
(statement_directive) @statement.outer

; @parameter
(arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(parameters
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(parameters
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

