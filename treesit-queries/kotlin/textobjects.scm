(function_declaration
  (function_body)? @function.inner) @function.outer

; Unlike function_body above, the constructor body is does not have its own
; symbol in the current grammar.
(secondary_constructor) @function.outer

(class_declaration
  (class_body)? @class.inner) @class.outer

(class_declaration
  (enum_class_body) @class.inner) @class.outer

[
  (line_comment)
  (multiline_comment)
] @comment.inner

(line_comment)+ @comment.outer

(multiline_comment) @comment.outer

(enum_entry) @entry.outer
(lambda_literal) @entry.outer
(property_declaration) @entry.outer
(object_declaration) @entry.outer
(assignment) @entry.outer

; TODO: This doesn't work with annotations yet, but fixing it without breaking
; the case of multiple parameters is non-trivial.
(function_value_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; secondary constructor uses function_value_parameters above
(primary_constructor
  ((_)@parameter.inner . ","? @parameter.outer) @parameter.outer)

(function_type_parameters
  ((_)@parameter.inner . ","? @parameter.outer) @parameter.outer)

(value_arguments
  ((_)@parameter.inner . ","? @parameter.outer) @parameter.outer)
