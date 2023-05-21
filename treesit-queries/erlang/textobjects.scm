(function_clause
  pattern: (arguments (_)? @parameter.inner)
  body: (_) @function.inner) @function.outer

(anonymous_function
  (stab_clause body: (_) @function.inner)) @function.outer

(comment (comment_content) @comment.inner) @comment.outer

; EUnit test names.
; (CommonTest cases are not recognizable by syntax alone.)
((function_clause
   name: (atom) @_name
   pattern: (arguments (_)? @parameter.inner)
   body: (_) @test.inner) @test.outer
 (#match "_test$" @_name))
