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
] @statement.outer

[
  (chapter)
  (part)
  (section)
  (subsection)
  (subsubsection)
  (paragraph)
  (subparagraph)
] @class.outer

