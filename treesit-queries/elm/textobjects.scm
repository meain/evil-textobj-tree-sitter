(line_comment) @comment.inner
(line_comment)+ @comment.outer
(block_comment) @comment.inner
(block_comment)+ @comment.outer

((type_annotation)?
  (value_declaration
    (function_declaration_left (lower_case_identifier))
    (eq)
    (_) @function.inner
  )
) @function.outer

(parenthesized_expr
  (anonymous_function_expr
    (
      (arrow)
      (_) @function.inner
    )
  )
) @function.outer

(value_declaration
  (function_declaration_left
    (lower_pattern
      (lower_case_identifier) @parameter.inner @parameter.outer
    )
  )
)

(value_declaration
  (function_declaration_left
    (pattern) @parameter.inner @parameter.outer
  )
)

(value_declaration
  (function_declaration_left
    (tuple_pattern
      (pattern) @parameter.inner
    ) @parameter.outer
  )
)

(value_declaration
  (function_declaration_left
    (record_pattern
      (lower_pattern
        (lower_case_identifier) @parameter.inner
      )
    ) @parameter.outer
  )
)

(parenthesized_expr
  (anonymous_function_expr
    (
      (backslash)
      (pattern) @parameter.inner
      (arrow)
    )
  )
)
