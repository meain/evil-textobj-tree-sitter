(function_item
  body: (_) @function.inner) @function.outer

(closure_expression
  body: (_) @function.inner) @function.outer

(struct_item
  body: (_) @class.inner) @class.outer

(enum_item
  body: (_) @class.inner) @class.outer

(union_item
  body: (_) @class.inner) @class.outer

(trait_item
  body: (_) @class.inner) @class.outer

(impl_item
  body: (_) @class.inner) @class.outer

(parameters 
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(type_arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(closure_parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(field_initializer_list  
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

[
  (line_comment)
  (block_comment)
] @comment.inner

(line_comment)+ @comment.outer

(block_comment) @comment.outer

(; #[test]
 (attribute_item
   (attribute
     (identifier) @_test_attribute))
 ; allow other attributes like #[should_panic] and comments
 [
   (attribute_item)
   (line_comment)
 ]*
 ; the test function
 (function_item
   body: (_) @test.inner) @test.outer
 (#equal @_test_attribute "test"))

(array_expression
  (_) @entry.outer)

(tuple_expression
  (_) @entry.outer)

(tuple_pattern
  (_) @entry.outer)

; Commonly used vec macro intializer is special cased
(macro_invocation
  (identifier) @_id (token_tree (_) @entry.outer)
  (#equal @_id "vec"))

(enum_variant) @entry.outer

(field_declaration
  (_) @entry.inner) @entry.outer

(field_initializer
  (_) @entry.inner) @entry.outer

(shorthand_field_initializer) @entry.outer
