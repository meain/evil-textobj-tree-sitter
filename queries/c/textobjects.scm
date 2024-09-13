; TODO: supported by official Tree-sitter  if (_)* is more than one node
; Neovim: will only match if (_) is exactly one node
;(function_definition
;body:  (compound_statement
;("{" (_)* @function.inner "}"))?) @function.outer
(declaration
  declarator: (function_declarator)) @function.outer

(function_definition
  body: (compound_statement)) @function.outer

(function_definition
  body: (compound_statement
    .
    "{"
    .
    (_)  @function.inner._start  @function.inner._end
    (_)?  @function.inner._end
    .
    "}"
    ))

(struct_specifier
  body: (_) @class.inner) @class.outer

(enum_specifier
  body: (_) @class.inner) @class.outer

; conditionals
(if_statement
  consequence: (compound_statement
    .
    "{"
    .
    (_)  @conditional.inner._start  @conditional.inner._end
    (_)?  @conditional.inner._end
    .
    "}"
    )) @conditional.outer

(if_statement
  alternative: (else_clause
    (compound_statement
      .
      "{"
      .
      (_)  @conditional.inner._start  @conditional.inner._end
      (_)?  @conditional.inner._end
      .
      "}"
      ))) @conditional.outer

(if_statement) @conditional.outer

(if_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(while_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(do_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(for_statement
  condition: (_) @conditional.inner)

; loops
(while_statement) @loop.outer

(while_statement
  body: (compound_statement
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(for_statement) @loop.outer

(for_statement
  body: (compound_statement
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(do_statement) @loop.outer

(do_statement
  body: (compound_statement
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    )) @loop.outer

(compound_statement) @block.outer

(comment) @comment.outer

(call_expression) @call.outer

(call_expression
  arguments: (argument_list
    .
    "("
    .
    (_)  @call.inner._start
    (_)?  @call.inner._end
    .
    ")"
    ))

(return_statement
  (_)? @return.inner) @return.outer

; Statements
;(expression_statement ;; this is what we actually want to capture in most cases (";" is missing) probably
;(_) @statement.inner) ;; the other statement like node type is declaration but declaration has a ";"
(compound_statement
  (_) @statement.outer)

(field_declaration_list
  (_) @statement.outer)

(preproc_if
  (_) @statement.outer)

(preproc_elif
  (_) @statement.outer)

(preproc_else
  (_) @statement.outer)

((parameter_list
  ","  @parameter.outer._start
  .
  (parameter_declaration) @parameter.inner @parameter.outer._end)
  )

((parameter_list
  .
  (parameter_declaration) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(number_literal) @number.inner

(declaration
  declarator: (init_declarator
    declarator: (_) @assignment.lhs
    value: (_) @assignment.rhs) @assignment.inner) @assignment.outer

(declaration
  type: (primitive_type)
  declarator: (_) @assignment.inner)

(expression_statement
  (assignment_expression
    left: (_) @assignment.lhs
    right: (_) @assignment.rhs) @assignment.inner) @assignment.outer

