(function_def) @function.outer
(function_def
  . (function_command)
  . (_)?  @function.inner._start
  (_)  @function.inner._end
  . (endfunction_command) .
  )

(if_condition) @conditional.outer
(if_condition
  . (if_command)
  . (_)?  @conditional.inner._start
  (_)  @conditional.inner._end
  . (endif_command) .
  )

(foreach_loop) @loop.outer
(foreach_loop
  . (foreach_command)
  . (_)?  @loop.inner._start
  (_)  @loop.inner._end
  . (endforeach_command) .
  )


(normal_command) @call.outer
(normal_command
  "(" . (_)  @call.inner._start
  (_)?  @call.inner._end . ")"
  )

(line_comment) @comment.outer

