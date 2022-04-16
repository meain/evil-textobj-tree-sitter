(class_declaration
  body: (class_body) @class.inner) @class.outer

(method_declaration) @function.outer

(method_declaration
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

(constructor_declaration) @function.outer

(constructor_declaration
  body: (constructor_body . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

(for_statement
  body: (_)? @loop.inner) @loop.outer

(enhanced_for_statement
  body: (_)? @loop.inner) @loop.outer

(while_statement
  body: (_)? @loop.inner) @loop.outer

(do_statement
  body: (_)? @loop.inner) @loop.outer

(if_statement
  condition: (_ (parenthesized_expression) @conditional.inner)  @conditional.outer)

(if_statement
  consequence: (_)? @conditional.inner
  alternative: (_)? @conditional.inner
  ) @conditional.outer

(switch_expression
  body: (_)? @conditional.inner) @conditional.outer

;; blocks
(block) @block.outer


(method_invocation) @call.outer
(method_invocation (argument_list) @call.inner)

;; parameters
(formal_parameters
  ","  @parameter.outer._start .
  (formal_parameter) @parameter.inner @parameter.outer._end
 )
(formal_parameters
  . (formal_parameter) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

(argument_list
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
 )
(argument_list
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

[
  (line_comment)
  (block_comment)
] @comment.outer

