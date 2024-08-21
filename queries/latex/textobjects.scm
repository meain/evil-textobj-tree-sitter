((generic_environment
  begin: (_)
  .
  (_)  @block.inner._start
  (_)?  @block.inner._end
  .
  end: (_)) @block.outer
  )

((math_environment
  begin: (_)
  .
  (_)  @block.inner._start
  (_)?  @block.inner._end
  .
  end: (_)) @block.outer
  )

(generic_environment
  begin: (begin
    name: (curly_group_text
      text: (text) @frame.inner))) @frame.outer

(math_environment
  begin: (begin
    name: (curly_group_text
      text: (text) @frame.inner))) @frame.outer

[
  (generic_command)
  (text_mode)
] @call.outer

(text_mode
  (curly_group
    "{"
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    "}")
  )

(generic_command
  (curly_group
    "{"
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    "}")
  )

((part
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((chapter
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((section
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((subsection
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((subsubsection
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((paragraph
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

((subparagraph
  text: (_)
  .
  (_)  @class.inner._start
  (_)?  @class.inner._end .) @class.outer
  )

