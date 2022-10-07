;; functions
(function_definition
  body: (compound_statement . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
  ))
(function_definition) @function.outer

;; methods
(method_declaration
  body: (compound_statement . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
  ))
(method_declaration) @function.outer

;; classes
(class_declaration
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  ))
(class_declaration) @class.outer

;; loops
(for_statement
  (compound_statement . "{" . (_)  @loop.inner._start  @loop.inner._end (_)?  @loop.inner._end . "}"
  ))
(for_statement) @loop.outer

(foreach_statement
  body: (compound_statement . "{" . (_)  @loop.inner._start  @loop.inner._end (_)?  @loop.inner._end . "}"
  ))
(foreach_statement) @loop.outer

(while_statement
  body: (compound_statement . "{" . (_)  @loop.inner._start  @loop.inner._end (_)?  @loop.inner._end . "}"
  ))
(while_statement) @loop.outer

(do_statement
  body: (compound_statement . "{" . (_)  @loop.inner._start  @loop.inner._end (_)?  @loop.inner._end . "}"
  ))
(do_statement) @loop.outer

;; conditionals
(switch_statement
  body: (switch_block . "{" . (_)  @conditional.inner._start  @conditional.inner._end (_)?  @conditional.inner._end . "}"
  ))
(switch_statement) @conditional.outer

(if_statement
  body: (compound_statement . "{" . (_)  @conditional.inner._start  @conditional.inner._end (_)?  @conditional.inner._end . "}"
  ))
(if_statement) @conditional.outer

(else_clause
  body: (compound_statement . "{" . (_)  @conditional.inner._start  @conditional.inner._end (_)?  @conditional.inner._end . "}"
  )
)

(else_if_clause
  body: (compound_statement . "{" . (_)  @conditional.inner._start  @conditional.inner._end (_)?  @conditional.inner._end . "}"
  )
)

;; blocks
(_ (switch_block) @block.inner) @block.outer

;; parameters
(arguments
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
  )
(arguments
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
  )

(formal_parameters
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
  )
(formal_parameters
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
  )

;; comments
(comment) @comment.outer

;; call
(function_call_expression) @call.outer

(member_call_expression) @call.outer

(function_call_expression
  arguments: (arguments . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))

(member_call_expression
  arguments: (arguments . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))


