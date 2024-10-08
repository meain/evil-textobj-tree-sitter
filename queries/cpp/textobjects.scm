; inherits: c

(class_specifier
  body: (_) @class.inner) @class.outer

(field_declaration
  type: (enum_specifier)
  default_value: (initializer_list) @class.inner) @class.outer

(for_range_loop) @loop.outer

(for_range_loop
  body: (compound_statement
    .
    "{"
    .
    (_)  @loop.inner._start  @loop.inner._end
    (_)?  @loop.inner._end
    .
    "}"
    ))

(template_declaration
  (function_definition)) @function.outer

(template_declaration
  (struct_specifier)) @class.outer

(template_declaration
  (class_specifier)) @class.outer

((lambda_capture_specifier
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((lambda_capture_specifier
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((template_argument_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((template_argument_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((template_parameter_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end)
  )

((template_parameter_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((parameter_list
  ","  @parameter.outer._start
  .
  (optional_parameter_declaration) @parameter.inner @parameter.outer._end)
  )

((parameter_list
  .
  (optional_parameter_declaration) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

((initializer_list
  ","  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end @_end)
  )

((initializer_list
  .
  (_) @parameter.inner @parameter.outer._start
  .
  ","?  @parameter.outer._end)
  )

(new_expression
  (argument_list) @call.inner) @call.outer

