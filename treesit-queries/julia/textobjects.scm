(function_definition (_)? @function.inner) @function.outer

(short_function_definition (_)? @function.inner) @function.outer

(macro_definition (_)? @function.inner) @function.outer

(struct_definition (_)? @class.inner) @class.outer

(abstract_definition (_)? @class.inner) @class.outer

(primitive_definition (_)? @class.inner) @class.outer

(parameter_list
  ; Match all children of parameter_list *except* keyword_parameters
  ([(identifier)
    (slurp_parameter)
    (optional_parameter)
    (typed_parameter)
    (tuple_expression)
    (interpolation_expression)
    (call_expression)]
  @parameter.inner . ","? @parameter.outer) @parameter.outer)

(keyword_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(line_comment) @comment.inner

(line_comment)+ @comment.outer

(block_comment) @comment.inner

(block_comment)+ @comment.outer

(_expression (macro_identifier
    (identifier) @_name
    (#match "^(test|test_throws|test_logs|inferred|test_deprecated|test_warn|test_nowarn|test_broken|test_skip)$" @_name)
  )
  .
  (macro_argument_list) @test.inner) @test.outer
