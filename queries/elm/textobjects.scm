;; Functions
; top level function with type annotation and doc comment
(
  (module_declaration)
  (block_comment) @function.outer.start
  .
  (type_annotation)
  .
  (value_declaration
    body: (_)? @function.inner) @function.outer
)

; top level function with type annotation
(
  (module_declaration)
  (type_annotation) @function.outer.start
  .
  (value_declaration
    body: (_)? @function.inner) @function.outer
)

; top level function without type annotation
(
  (module_declaration)
  (value_declaration
    body: (_)? @function.inner) @function.outer
)

;; Comments
[
  (block_comment)
  (line_comment)
] @comment.outer

; Conditionals
(if_else_expr
    exprList: (_)
    exprList: (_) @conditional.inner) @conditional.outer

(case_of_expr
    branch: (case_of_branch) @conditional.inner) @conditional.outer

;; Parameters
; type annotations
((type_expression
    (arrow)  @parameter.outer._start .
    (type_ref) @parameter.inner @parameter.outer._end
  )
  )

((type_expression
    .
    (type_ref) @parameter.inner @parameter.outer._start
    . (arrow)?  @parameter.outer._end
  )
  )

; list items
((list_expr
    ","  @parameter.outer._start .
    exprList: (_) @parameter.inner @parameter.outer._end
  )
  )

((list_expr
    .
    exprList: (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

; tuple items
((tuple_expr
    ","  @parameter.outer._start .
    expr: (_) @parameter.inner @parameter.outer._end
  )
  )

((tuple_expr
    .
    expr: (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

