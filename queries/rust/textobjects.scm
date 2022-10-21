;; functions
(function_item
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
  )) @function.outer

;; quantifies as class(es)
(struct_item
  body: (field_declaration_list . "{" . (_)  @class.inner._start [(_)","]?  @class.inner._end . "}"
  )) @class.outer

(enum_item
  body: (enum_variant_list . "{" . (_)  @class.inner._start [(_)","]?  @class.inner._end . "}"
  )) @class.outer

(union_item
  body: (field_declaration_list . "{" . (_)  @class.inner._start [(_)","]?  @class.inner._end . "}"
  )) @class.outer

(trait_item
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  )) @class.outer

(impl_item
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  )) @class.outer

(mod_item
  body: (declaration_list . "{" . (_)  @class.inner._start  @class.inner._end (_)?  @class.inner._end . "}"
  )) @class.outer

;; conditionals
(if_expression
  alternative: (_ (_) @conditional.inner)?
  ) @conditional.outer

(if_expression
  alternative: (else_clause (block) @conditional.inner))

(if_expression
  condition: (_) @conditional.inner)

(if_expression
  consequence: (block) @conditional.inner)

(match_arm
  (_)) @conditional.inner

(match_expression) @conditional.outer

(if_let_expression
  consequence: (block)?
  @conditional.inner) @conditional.outer

(if_let_expression
  alternative: (else_clause (block) @conditional.inner))

(if_let_expression
  pattern: (_) @conditional.inner)

;; loops
(loop_expression
  (_)? @loop.inner) @loop.outer

(while_expression
  (_)? @loop.inner) @loop.outer

(while_let_expression
  (_)? @loop.inner) @loop.outer

(for_expression
  body: (block)? @loop.inner) @loop.outer

;; blocks
(_ (block) @block.inner) @block.outer
(unsafe_block (_)? @block.inner) @block.outer

;; calls
(call_expression) @call.outer
(call_expression
  arguments: (arguments . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))

;; statements
(block (_) @statement.outer)

;; comments
(line_comment) @comment.outer
(block_comment) @comment.outer

;; parameter

((parameters
  ","  @parameter.outer._start . (parameter) @parameter.inner @parameter.outer._end)
 )
((parameters
  . (parameter) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((type_parameters
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((type_parameters
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((tuple_pattern
  ","  @parameter.outer._start . (identifier) @parameter.inner @parameter.outer._end)
 )
((tuple_pattern
  . (identifier) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((tuple_struct_pattern
  ","  @parameter.outer._start . (identifier) @parameter.inner @parameter.outer._end)
 )
((tuple_struct_pattern
  . (identifier) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((closure_parameters
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((closure_parameters
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((arguments
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((arguments
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((type_arguments
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((type_arguments
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )

((meta_arguments
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 )
((meta_arguments
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 )


