;; inner function textobject
(function_declaration
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

;; inner function literals
(func_literal
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

;; method as inner function textobject
(method_declaration
  body: (block . "{" . (_)  @function.inner._start  @function.inner._end (_)?  @function.inner._end . "}"
 ))

;; outer function textobject
(function_declaration) @function.outer

;; outer function literals
(func_literal (_)?) @function.outer

;; method as outer function textobject
(method_declaration body: (block)?) @function.outer


;; struct and interface declaration as class textobject?
(type_declaration
    (type_spec (type_identifier) (struct_type (field_declaration_list (_)?) @class.inner))) @class.outer

(type_declaration
  (type_spec (type_identifier) (interface_type) @class.inner)) @class.outer

;; struct literals as class textobject
(composite_literal
  (type_identifier)?
  (struct_type (_))?
  (literal_value (_)) @class.inner) @class.outer

;; conditionals
(if_statement
  alternative: (_ (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block)? @conditional.inner)

(if_statement
  condition: (_) @conditional.inner)

;; loops
(for_statement
  body: (block)? @loop.inner) @loop.outer

;; blocks
(_ (block) @block.inner) @block.outer

;; statements
(block (_) @statement.outer)

;; comments
(comment) @comment.outer

;; calls
(call_expression (_)? @call.inner) @call.outer

;; parameters
(parameter_list
  ","  @parameter.outer._start .
  (parameter_declaration) @parameter.inner @parameter.outer._end
 )
(parameter_list
  . (parameter_declaration) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

(parameter_declaration
  (identifier)
  (identifier) @parameter.inner)

(parameter_declaration
  (identifier) @parameter.inner
  (identifier))

(parameter_list
  ","  @parameter.outer._start .
  (variadic_parameter_declaration) @parameter.inner @parameter.outer._end
 )

;; arguments
(argument_list
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
 )
(argument_list
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

