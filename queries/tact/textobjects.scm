; See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
; function.inner & outer
; ----------------------
; global
(global_function
  body: (_)) @function.outer

(global_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; init
(init_function
  body: (_)) @function.outer

(init_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; bounced
(bounced_function
  body: (_)) @function.outer

(bounced_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; receive
(receive_function
  body: (_)) @function.outer

(receive_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; external
(external_function
  body: (_)) @function.outer

(external_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; contract/trait function
(storage_function
  body: (_)) @function.outer

(storage_function
  body: (function_body
    .
    "{"
    .
    (_)  @function.inner._start
    (_)?  @function.inner._end
    .
    "}")
  )

; class.inner & outer
; -------------------
(struct) @class.outer

(struct
  body: (struct_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}")
  )

(message) @class.outer

(message
  body: (message_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}")
  )

(contract) @class.outer

(contract
  body: (contract_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}")
  )

(trait) @class.outer

(trait
  body: (trait_body
    .
    "{"
    .
    (_)  @class.inner._start
    (_)?  @class.inner._end
    .
    "}")
  )

; attribute.inner & outer
; -----------------------
("@name"
  "("
  func_name: (func_identifier) @attribute.inner
  ")") @attribute.outer

(contract_attributes
  ("@interface"
    "("
    (string) @attribute.inner
    ")") @attribute.outer)

(trait_attributes
  ("@interface"
    "("
    (string) @attribute.inner
    ")") @attribute.outer)

(trait_attributes
  ("@interface"
    "("
    (string) @attribute.inner
    ")") @attribute.outer)

; loop.inner & outer
; ------------------
(while_statement) @loop.outer

(while_statement
  body: (block_statement
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    ))

(repeat_statement) @loop.outer

(repeat_statement
  body: (block_statement
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    ))

(do_until_statement) @loop.outer

(do_until_statement
  body: (block_statement
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    ))

(foreach_statement) @loop.outer

(foreach_statement
  body: (block_statement
    .
    "{"
    .
    (_)  @loop.inner._start
    (_)?  @loop.inner._end
    .
    "}"
    ))

; conditional.inner & outer
; -------------------------
(if_statement) @conditional.outer

(if_statement
  consequence: (block_statement
    .
    "{"
    .
    (_)  @conditional.inner._start
    (_)?  @conditional.inner._end
    .
    "}"
    ))

(if_statement
  alternative: (else_clause
    (block_statement
      .
      "{"
      .
      (_)  @conditional.inner._start
      (_)?  @conditional.inner._end
      .
      "}"
      )))

; block.inner & outer
; -------------------
(_
  (block_statement) @block.inner) @block.outer

; call.inner & outer
; ------------------
(method_call_expression) @call.outer

(method_call_expression
  arguments: (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(static_call_expression) @call.outer

(static_call_expression
  arguments: (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(instance_expression) @call.outer

(instance_expression
  arguments: (instance_argument_list
    .
    "{"
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    "}"
    ))

((initOf
  name: (identifier) @_name
  arguments: (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")") @_args)
  
  )

; return.inner & outer
; --------------------
(return_statement
  (_) @return.inner) @return.outer

; number.inner
; ------------
(integer) @number.inner

; parameter.inner & outer
; -----------------------
; second and following
(parameter_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

; first
(parameter_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; second and following
(argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

; first
(argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; second and following
(instance_argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

; first
(instance_argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; single parameter
(receive_function
  parameter: (_) @parameter.inner @parameter.outer)

(bounced_function
  parameter: (_) @parameter.inner @parameter.outer)

(external_function
  parameter: (_) @parameter.inner @parameter.outer)

; assignment.inner & outer w/ lhs & rhs
; -------------------------------------
(let_statement
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(storage_variable
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(global_constant
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(storage_constant
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

(field
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

; comment.inner & outer
; ---------------------
(comment) @comment.inner @comment.outer

; quantified captures aren't supported yet:
; (comment)+ @comment.outer

