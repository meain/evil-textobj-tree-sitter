; class
((
  [(marker_annotation)? (annotation)?] @class.outer.start .
  (class_definition 
    body: (class_body)  @class.outer._end @class.inner)  @class.outer._start
 )
 )
(mixin_declaration (class_body) @class.inner) @class.outer
(enum_declaration
  body: (enum_body) @class.inner) @class.outer
(extension_declaration
  body: (extension_body) @class.inner) @class.outer

; function/method
(( 
  [(marker_annotation)? (annotation)?] @function.outer.start .
  [(method_signature) (function_signature)]  @function.outer._start .
  (function_body)  @function.outer._end
 )
 )

(function_body
  (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

(type_alias (function_type)? @function.inner) @function.outer

; parameter
[
  (formal_parameter)
  (normal_parameter_type)
  (type_parameter)
] @parameter.inner
(
","  @parameter.outer._start . [
  (formal_parameter)
  (normal_parameter_type)
  (type_parameter)
 ] @_par @parameter.outer._end
 )
(
 [
  (formal_parameter)
  (normal_parameter_type)
  (type_parameter)
 ] @_par @parameter.outer._start . ","  @parameter.outer._end 
 )

;; TODO: (_)* not supported yet -> for now this works correctly only with simple arguments 
((arguments
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )
((arguments
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )

; call
(expression_statement
  (selector) @call.inner) @call.outer

; block
(block) @block.outer

; conditional
(if_statement
  [
    condition: (_)
    consequence: (_)
    alternative: (_)?
  ] @conditional.inner) @conditional.outer
(switch_statement
  body: (switch_block) @conditional.inner) @conditional.outer
(conditional_expression
  [
    consequence: (_)
    alternative: (_)
  ] @conditional.inner) @conditional.outer

; loop
(for_statement
  body: (block) @loop.inner) @loop.outer
(while_statement
  body: (block) @loop.inner) @loop.outer
(do_statement
  body: (block) @loop.inner) @loop.outer

; comment
[
  (comment)
  (documentation_comment)
] @comment.outer

; statement
[
  (break_statement)
  (do_statement)
  (expression_statement)
  (for_statement)
  (if_statement)
  (return_statement)
  (switch_statement)
  (while_statement)
  (assert_statement)
  ;(labeled_statement)
  (yield_statement)
  (yield_each_statement)
  (continue_statement)
  (try_statement)
] @statement.outer

