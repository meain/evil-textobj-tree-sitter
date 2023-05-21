(lambda_expression
  (label) @parameter.inner
  (expression) @function.inner
) @function.outer

(forall_expression
  (label) @parameter.inner
  (expression) @function.inner
) @function.outer

(assert_expression
  (expression) @test.inner
) @test.outer

[
  (block_comment_content)
  (line_comment_content)
] @comment.inner

[
  (block_comment)
  (line_comment)
] @comment.outer
