(class_definition
  body: (_) @class.inner) @class.outer

(mixin_declaration
  (class_body) @class.inner) @class.outer

(extension_declaration
  (extension_body) @class.inner) @class.outer

(enum_declaration
  body: (_) @class.inner) @class.outer

(type_alias) @class.outer

(_
  (
    [
      (getter_signature)
      (setter_signature)
      (function_signature)
      (method_signature)
      (constructor_signature)
    ]
    .
    (function_body) @function.inner @function.outer
  )  @function.outer
)

(declaration
  [
    (constant_constructor_signature)
    (constructor_signature)
    (factory_constructor_signature)
    (redirecting_factory_constructor_signature)
    (getter_signature)
    (setter_signature)
    (operator_signature)
    (function_signature)
  ]
) @function.outer

(lambda_expression
    body: (_) @function.inner
) @function.outer

(function_expression
    body: (_) @function.inner
) @function.outer

[
  (comment)
  (documentation_comment)
] @comment.inner

(comment)+ @comment.outer

(documentation_comment)+ @comment.outer

(formal_parameter_list
  (
    (formal_parameter) @parameter.inner . ","? @parameter.outer
  ) @parameter.outer
)

(optional_formal_parameters
  (
    (formal_parameter) @parameter.inner . ","? @parameter.outer
  ) @parameter.outer
)

(arguments
  (
    [
      (argument) @parameter.inner
      (named_argument (label) . (_)* @parameter.inner)
    ]
    . ","? @parameter.outer
  ) @parameter.outer
)

(type_arguments
  (
    ((_) . ("." . (_) @parameter.inner @parameter.outer)?) @parameter.inner
    . ","? @parameter.outer
  ) @parameter.outer
)

(expression_statement
  ((identifier) @_name (#any-of? @_name "test" "testWidgets"))
  .
  (selector (argument_part (arguments . (_) . (argument) @test.inner)))
) @test.outer

