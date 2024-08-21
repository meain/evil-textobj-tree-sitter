; Classes
(class) @class.outer

(class
  body: (class_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}"
    ))

; Traits
(trait) @class.outer

(trait
  body: (trait_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}"
    ))

; Implementations
(implement_trait) @class.outer

(implement_trait
  body: (implement_trait_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}"
    ))

(reopen_class) @class.outer

(reopen_class
  body: (reopen_class_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}"
    ))

; Methods and closures
(method) @function.outer

(method
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}"
    ))

(closure) @function.outer

(closure
  body: (block
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}"
    ))

; Loops
(while
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(while
  condition: (_) @conditional.inner)

(loop
  body: (block
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

; Conditionals
(if
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if
  alternative: (else
    (block) @conditional.inner))

(if
  consequence: (block)? @conditional.inner)

(if
  condition: (_) @conditional.inner)

(case) @conditional.inner

(match) @conditional.outer

; Method calls
(call) @call.outer

(call
  arguments: (arguments
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(return
  (_)? @return.inner) @return.outer

; Call and type arguments
((arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((type_arguments
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((type_arguments
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

; Patterns
((class_pattern
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((class_pattern
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((tuple_pattern
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((tuple_pattern
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

; Sequence types
(tuple
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(tuple
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(array
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(array
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; Blocks
(block
  (_)? @block.inner) @block.outer

; Comments
(line_comment) @comment.outer

; Numbers
[
  (integer)
  (float)
] @number.inner

; Variable definitions and assignments
(define_variable
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(define_constant
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assign_local
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assign_field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assign_receiver_field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(replace_local
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(replace_field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(compound_assign_local
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(compound_assign_field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(compound_assign_receiver_field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

