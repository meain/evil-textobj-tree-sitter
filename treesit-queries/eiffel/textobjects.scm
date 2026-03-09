[
  (comment)+
  (header_comment)+
] @comment.outer
[
  (comment)
  (header_comment)
] @comment.inner
(formal_arguments) @parameter.outer
(entity_declaration_group) @parameter.inner
(attribute_or_routine) @function.outer
(feature_body) @function.inner
(class_declaration) @class.outer
(feature_clause) @class.inner

