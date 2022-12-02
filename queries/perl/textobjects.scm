(comments) @comment.outer

(pattern_matcher (regex_pattern) @regex.inner) @regex.outer

((patter_matcher_m
   (start_delimiter)  @regex.inner._start
   (end_delimiter)  @regex.inner._end) @regex.outer
 )

((regex_pattern_qr
   (start_delimiter)  @regex.inner._start
   (end_delimiter)  @regex.inner._end) @regex.outer
 )

