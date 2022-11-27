(class_declaration 
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  )) @class.outer

(struct_declaration
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  )) @class.outer

(method_declaration
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
  )) @function.outer

(lambda_expression 
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
  )) @function.outer

;; loops
(for_statement
  body: (_) @loop.inner) @loop.outer

(for_each_statement
  body: (_) @loop.inner) @loop.outer

(do_statement
  (block) @loop.inner) @loop.outer

(while_statement
  (block) @loop.inner) @loop.outer

;; conditionals
(if_statement
  consequence: (_)? @conditional.inner
  alternative: (_)? @conditional.inner) @conditional.outer

(switch_statement
  body: (switch_body) @conditional.inner) @conditional.outer

;; calls
(invocation_expression) @call.outer
(invocation_expression
  arguments: (argument_list . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))

;; blocks
(_ (block) @block.inner) @block.outer

;; parameters
((parameter_list
  ","  @parameter.outer._start . (parameter) @parameter.inner @parameter.outer._end)
 ) 

((parameter_list
  . (parameter) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 ) 

((argument_list
  ","  @parameter.outer._start . (argument) @parameter.inner @parameter.outer._end)
 ) 

((argument_list
  . (argument) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 ) 

;; comments
(comment) @comment.outer

