(subroutine_declaration_statement
  body: (_) @function.inner) @function.outer
(anonymous_subroutine_expression
  body: (_) @function.inner) @function.outer

(package_statement) @class.outer
(package_statement
  (block) @class.inner)

(list_expression
  (_) @parameter.inner)

(comment) @comment.outer
(pod) @comment.outer
