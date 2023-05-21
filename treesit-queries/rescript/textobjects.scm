; Classes (modules)
;------------------

(module_declaration definition: ((_) @class.inner)) @class.outer

; Blocks
;-------

(block (_) @function.inner) @function.outer

; Functions
;----------

(function body: (_) @function.inner) @function.outer

; Calls
;------

(call_expression arguments: ((_) @parameter.inner)) @parameter.outer

; Comments
;---------

(comment) @comment.inner
(comment)+ @comment.outer

; Parameters
;-----------

(function parameter: (_) @parameter.inner @parameter.outer)

(formal_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(formal_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(arguments
  "," @_arguments_start
  . (_) @parameter.inner
  @parameter.outer)
(arguments
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(function_type_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(function_type_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(functor_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(functor_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(type_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(type_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(type_arguments
  ","
  . (_) @parameter.inner
  @parameter.outer)
(type_arguments
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(decorator_arguments
  ","
  . (_) @parameter.inner
  @parameter.outer)
(decorator_arguments
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(variant_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(variant_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

(polyvar_parameters
  ","
  . (_) @parameter.inner
  @parameter.outer)
(polyvar_parameters
  . (_) @parameter.inner
  . ","?
  @parameter.outer)

