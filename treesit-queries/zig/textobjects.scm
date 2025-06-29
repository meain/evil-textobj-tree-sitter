(function_declaration
  body: (_) @function.inner) @function.outer

(test_declaration (_) (block) @test.inner) @test.outer

; matches all of: struct, enum, union
; this unfortunately cannot be split up because
; of the way struct "container" types are defined
(variable_declaration (identifier) (struct_declaration
    (_) @class.inner)) @class.outer

(variable_declaration (identifier) (enum_declaration
    (_) @class.inner)) @class.outer

(variable_declaration (identifier) (enum_declaration
    (_) @class.inner)) @class.outer

(parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner
(comment)+ @comment.outer
