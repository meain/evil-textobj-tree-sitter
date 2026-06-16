(function_definition (_)? @function.inner) @function.outer

; Short-form `f(x) = …` is now an assignment with a call_expression LHS.
((assignment . (call_expression)) @function.inner) @function.outer

(macro_definition (_)? @function.inner) @function.outer

(struct_definition (_)? @class.inner) @class.outer

(abstract_definition (_)? @class.inner) @class.outer

(primitive_definition (_)? @class.inner) @class.outer

; Parameters and call arguments both live in argument_list now.
(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(curly_expression
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(line_comment) @comment.inner

(line_comment)+ @comment.outer

(block_comment) @comment.inner

(block_comment)+ @comment.outer

(macrocall_expression (macro_identifier
    (identifier) @_name
    (#match "^(test|test_throws|test_logs|inferred|test_deprecated|test_warn|test_nowarn|test_broken|test_skip)$" @_name)
  )
  .
  (macro_argument_list) @test.inner) @test.outer
