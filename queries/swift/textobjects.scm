(class_declaration
  body: (class_body . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
 )) @class.outer

(class_declaration
  body: (enum_class_body . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
 )) @class.outer

(function_declaration
  body: (function_body . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 )) @function.outer

(lambda_literal
  ("{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 )) @function.outer

(call_suffix
  (value_arguments . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
 )) @call.outer

(value_argument
  value: ((_) @parameter.inner)) @parameter.outer

(comment) @comment.outer

(multiline_comment) @comment.outer

