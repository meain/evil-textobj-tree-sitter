; Function queries

(function_definition
  body: (_) @function.inner) @function.outer ; Does not include end marker

(lambda_expression
  (_) @function.inner) @function.outer

; Scala 3 braceless lambda
(colon_argument
  (_) @function.inner) @function.outer


; Class queries

(object_definition
  body: (_)? @class.inner) @class.outer

(class_definition
  body: (_)? @class.inner) @class.outer

(trait_definition
  body: (_)? @class.inner) @class.outer

(type_definition) @class.outer

(enum_case_definitions) @class.outer

(enum_definition
  body: (_)? @class.inner) @class.outer


; Parameter queries

(parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(class_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(parameter_types
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(bindings
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; Does not match context bounds or higher-kinded types
(type_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)


; Comment queries

[(comment) (block_comment)] @comment.inner
[(comment) (block_comment)] @comment.outer ; Does not match consecutive block comments


; Test queries
; Not supported
