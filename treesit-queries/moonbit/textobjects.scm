; Functions

((function_definition
  ("fn"
   (block_expression) @function.inner)
   (#offset! @function.inner 0 1 0 -1))
 @function.outer)

((function_definition
  (external_source (_) @function.inner)
  .)
 @function.outer)

(trait_method_declaration) @function.outer

((impl_definition
  ("impl"
   (block_expression) @function.inner)
   (#offset! @function.inner 0 1 0 -1))
 @function.outer)

; Tests

((test_definition
  ("test"
   (block_expression) @test.inner)
   (#offset! @test.inner 0 1 0 -1))
 @test.outer)

; Classes (type-like definitions)

(struct_definition) @class.outer
(enum_definition) @class.outer
(trait_definition) @class.outer
(type_definition) @class.outer

; Parameters

((parameters
  .
  (parameter) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.around" @parameter.inner @_end))

((trait_method_declaration
  (trait_method_parameter) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.around" @parameter.inner @_end))

((apply_expression
  (arguments
   (argument) @parameter.inner
   .
   ","? @_end))
  (#make-range! "parameter.around" @parameter.inner @_end))

((dot_apply_expression
  (argument) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.around" @parameter.inner @_end))

((dot_dot_apply_expression
  (argument) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.around" @parameter.inner @_end))

((array_expression
  (_) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.around" @parameter.inner @_end))

; Comments

(comment) @comment.outer
(block_comment) @comment.outer
