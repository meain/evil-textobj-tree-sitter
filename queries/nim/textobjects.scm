; ==============================================================================
; @attribute.inner
; @attribute.outer
; ==============================================================================
; @function.inner
; @function.outer
(proc_declaration
  body: (statement_list) @function.inner) @function.outer

(func_declaration
  body: (statement_list) @function.inner) @function.outer

(method_declaration
  body: (statement_list) @function.inner) @function.outer

(iterator_declaration
  body: (statement_list) @function.inner) @function.outer

(converter_declaration
  body: (statement_list) @function.inner) @function.outer

(template_declaration
  body: (statement_list) @function.inner) @function.outer

(macro_declaration
  body: (statement_list) @function.inner) @function.outer

(proc_expression
  body: (statement_list) @function.inner) @function.outer

(func_expression
  body: (statement_list) @function.inner) @function.outer

(iterator_expression
  body: (statement_list) @function.inner) @function.outer

; ==============================================================================
; @class.inner
; @class.outer
; NOTE: seems pointless to handle just object declarations differently
; ==============================================================================
; @conditional.inner
; @conditional.outer
[
  (if)
  (when)
  (conditional_declaration)
  (case)
  (variant_declaration)
  (elif_branch)
  (else_branch)
  (of_branch)
] @conditional.outer

(if
  condition: (_) @conditional.inner)

(if
  consequence: (statement_list) @conditional.inner)

(when
  condition: (_) @conditional.inner)

(when
  consequence: (statement_list) @conditional.inner)

(conditional_declaration
  condition: (_) @conditional.inner)

(conditional_declaration
  consequence: (field_declaration_list) @conditional.inner)

(elif_branch
  condition: (_) @conditional.inner)

(elif_branch
  consequence: [
    (statement_list)
    (field_declaration_list)
  ] @conditional.inner)

(else_branch
  consequence: [
    (statement_list)
    (field_declaration_list)
  ] @conditional.inner)

(case
  value: (_) @conditional.inner)

(variant_declaration
  (variant_discriminator_declaration) @conditional.inner)

(of_branch
  values: (expression_list) @conditional.inner)

(of_branch
  consequence: [
    (statement_list)
    (field_declaration_list)
  ] @conditional.inner)

; ==============================================================================
; @loop.inner
; @loop.outer
[
  (for)
  (while)
] @loop.outer

(for
  left: (_)  @loop.inner._start
  right: (_)  @loop.inner._end
  )

(for
  body: (statement_list) @loop.inner)

(while
  condition: (_) @loop.inner)

(while
  body: (statement_list) @loop.inner)

; ==============================================================================
; @call.inner
; @call.outer
(call
  (argument_list) @call.inner) @call.outer

; NOTE: parenthesis are included in @call.inner
; ==============================================================================
; @block.inner
; @block.outer
(case
  ":"
  .
  (_)  @block.inner._start
  (_)  @block.inner._end
  .
  ) @block.outer

(object_declaration
  (field_declaration_list) @block.inner) @block.outer

(tuple_type
  .
  (field_declaration)  @block.inner._start
  (field_declaration)?  @block.inner._end
  .
  ) @block.outer

; BUG: @_end anchor not working correctly in all cases
(enum_declaration
  .
  (enum_field_declaration)  @block.inner._start
  (enum_field_declaration)?  @block.inner._end
  .
  ) @block.outer

; BUG: @_end anchor not working correctly in all cases
; using_section
; const_section
; let_section
; var_section
(_
  .
  (variable_declaration)  @block.inner._start
  (variable_declaration)  @block.inner._end
  .
  ) @block.outer

; BUG: @_end anchor not working correctly in all cases
(type_section
  .
  (type_declaration)  @block.inner._start
  (type_declaration)  @block.inner._end
  .
  ) @block.outer

; BUG: @_end anchor not working correctly in all cases
; (pragma_statement)
;
; (while)
; (static_statement)
; (defer)
;
; (block)
; (if)
; (when)
; (case)
; (try)
; (for)
;
; (proc_declaration)
; (func_declaration)
; (method_declaration)
; (iterator_declaration)
; (macro_declaration)
; (template_declaration)
; (converter_declaration)
;
; (proc_expression)
; (func_expression)
; (iterator_expression)
;
; (concept_declaration)
; (of_branch)
; (elif_branch)
; (else_branch)
; (except_branch)
; (finally_branch)
;
; (do_block)
; (call)
(_
  (statement_list) @block.inner) @block.outer

; ==============================================================================
; @parameter.inner
; @parameter.outer
; parameters when declaring
(parameter_declaration_list
  [
    ","
    ";"
  ]  @parameter.outer._start
  .
  (parameter_declaration) @parameter.inner @parameter.outer._end
  )

(parameter_declaration_list
  .
  (parameter_declaration) @parameter.inner @parameter.outer._start
  .
  [
    ","
    ";"
  ]?  @parameter.outer._end
  )

; generic parameters when declaring
(generic_parameter_list
  ","  @parameter.outer._start
  .
  (parameter_declaration) @parameter.inner @parameter.outer._end
  )

(generic_parameter_list
  .
  (parameter_declaration) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; arguments when calling
(argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; containers
(array_construction
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(array_construction
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(tuple_construction
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(tuple_construction
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(curly_construction
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(curly_construction
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; generic arguments when calling
; subscript operator
; generic types
(bracket_expression
  right: (argument_list
    ","  @parameter.outer._start
    .
    (_) @parameter.inner @parameter.outer._end)
  )

(bracket_expression
  right: (argument_list
    .
    (_) @parameter.inner @parameter.outer._start
    .
    ","?  @parameter.outer._end)
  )

; import x,x
; import except x,x
; include x,x
; from import x,x
; bind x,x
; mixin x,x
; case of x,x
; try except x,x
(expression_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(expression_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; pragmas
(pragma_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(pragma_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; variable_declaration
; for
; identifier_declaration `x,y: type = value`
(symbol_declaration_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(symbol_declaration_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; infix_expression
(infix_expression
  operator: (_)  @parameter.outer._start
  right: (_) @parameter.inner @parameter.outer._end
  )

(infix_expression
  left: (_) @parameter.inner @parameter.outer._start
  operator: (_)  @parameter.outer._end
  )

; tuple_type inline
(field_declaration_list
  [
    ","
    ";"
  ]  @parameter.outer._start
  .
  (field_declaration) @parameter.inner @parameter.outer._end
  )

(field_declaration_list
  .
  (field_declaration) @parameter.inner @parameter.outer._start
  .
  [
    ","
    ";"
  ]?  @parameter.outer._end
  )

; enum
(enum_declaration
  ","  @parameter.outer._start
  .
  (enum_field_declaration) @parameter.inner @parameter.outer._end
  )

(enum_declaration
  .
  (enum_field_declaration) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; tuple_deconstruct_declaration
(tuple_deconstruct_declaration
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(tuple_deconstruct_declaration
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; concept parameter list
; concept refinement list
(parameter_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(parameter_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

(refinement_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(refinement_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; dot_generic_call `v.call[:type, type]()
(generic_argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end
  )

(generic_argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end
  )

; ==============================================================================
; @regex.inner
; @regex.outer
; ==============================================================================
; @comment.inner
; @comment.outer
(comment
  (comment_content) @comment.inner) @comment.outer

(block_comment
  (comment_content) @comment.inner) @comment.outer

(documentation_comment
  (comment_content) @comment.inner) @comment.outer

(block_documentation_comment
  (comment_content) @comment.inner) @comment.outer

; ==============================================================================
; @assignment.inner
; @assignment.outer
; @assignment.lhs
; @assignment.rhs
(variable_declaration
  (symbol_declaration_list) @_symbols @assignment.lhs._start
  type: (type_expression)? @_type @assignment.lhs._end
  value: (_) @assignment.rhs @assignment.inner
  ) @assignment.outer

(type_declaration
  (type_symbol_declaration) @assignment.lhs
  .
  "="
  .
  (_) @assignment.rhs @assignment.inner) @assignment.outer

(assignment
  left: (_) @assignment.lhs
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; default parameter in proc decl
; keyword argument in call
; array construction
(colon_expression
  left: (_) @assignment.lhs
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; object construction
; tuple construction
; table construction
(equal_expression
  left: (_) @assignment.lhs
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; object declaration fields
; tuple declaration fields
(field_declaration
  (symbol_declaration_list) @_symbols @assignment.lhs._start
  type: (type_expression)? @_type @assignment.lhs._end
  value: (_)? @assignment.rhs @assignment.inner
  ) @assignment.outer

; enum types
(enum_field_declaration
  (symbol_declaration) @assignment.lhs
  "="?
  value: (_)? @assignment.rhs @assignment.inner) @assignment.outer

; ==============================================================================
; @return.inner
; @return.outer
(return_statement
  (_) @return.inner) @return.outer

; ==============================================================================
; @statement.outer
[
  ; simple
  (import_statement)
  (import_from_statement)
  (export_statement)
  (include_statement)
  (discard_statement)
  (return_statement)
  (raise_statement)
  (yield_statement)
  (break_statement)
  (continue_statement)
  (assembly_statement)
  (bind_statement)
  (mixin_statement)
  (pragma_statement)
  ; complex
  (while)
  (static_statement)
  (defer)
  ; declarations
  (proc_declaration)
  (func_declaration)
  (method_declaration)
  (iterator_declaration)
  (macro_declaration)
  (template_declaration)
  (converter_declaration)
  (using_section)
  (const_section)
  (let_section)
  (var_section)
  (type_section)
  ; expression statements
  (block)
  (if)
  (when)
  (case)
  (try)
  (for)
  (assignment)
  ; NOTE: not including
  ; simple_expression, call, infix_expression, prefix_expression
  ; because it would confusing
] @statement.outer

; ==============================================================================
; @scopename.inner
; ==============================================================================
; @number.inner
[
  (integer_literal)
  (float_literal)
] @number.inner

