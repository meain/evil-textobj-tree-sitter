(procedure_declaration (identifier) (procedure (block) @function.inner)) @function.outer
(procedure_declaration (identifier) (procedure (uninitialized) @function.inner)) @function.outer
(overloaded_procedure_declaration (identifier) @function.inner) @function.outer

(procedure_type (parameters (parameter (identifier) @parameter.inner) @parameter.outer))
(procedure (parameters (parameter (identifier) @parameter.inner) @parameter.outer))

((procedure_declaration
  (attributes (attribute "@" "(" (identifier) @attr_name ")"))
  (identifier) (procedure (block) @test.inner)) @test.outer
 (#match "test" @attr_name))

(comment) @comment.inner
(comment)+ @comment.outer
(block_comment) @comment.inner
(block_comment)+ @comment.outer

(struct_declaration (identifier) "::") @class.outer
(enum_declaration (identifier) "::") @class.outer
(union_declaration (identifier) "::") @class.outer
(bit_field_declaration (identifier) "::") @class.outer
(const_declaration (identifier) "::" [(array_type) (distinct_type) (bit_set_type) (pointer_type)]) @class.outer
