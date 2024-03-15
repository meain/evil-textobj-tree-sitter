((generic_environment
  . (_)
  . (_)  @block.inner._start
  (_)  @block.inner._end . (_) .
) @block.outer
)

((generic_environment
  (begin
   name: (curly_group_text
           (text) @_frame))
  . (_)  @frame.inner._start
  (_)  @frame.inner._end . (_) .) @frame.outer
 (#eq? @_frame "frame")
 ) 

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

[
  (chapter)
  (part)
  (section)
  (subsection)
  (subsubsection)
  (paragraph)
  (subparagraph)
] @class.outer

