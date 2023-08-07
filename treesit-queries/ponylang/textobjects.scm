;; Queries for helix to select textobjects: https://docs.helix-editor.com/usage.html#textobjects
;;  function.inside
;; function.around
;; class.inside
;; class.around
;; test.inside
;; test.around
;; parameter.inside
;; comment.inside
;; comment.around

;; Queries for navigating using textobjects

[
  (line_comment)
  (block_comment)
] @comment.inner

(line_comment)+ @comment.outer
(block_comment) @comment.outer

(entity members: (members)? @class.inner) @class.outer
(object members: (members)? @class.inner) @class.outer

(method
  body: (block)? @function.inner
) @function.outer
(behavior
  body: (block)? @function.inner
) @function.outer
(constructor
  body: (block)? @function.inner
) @function.outer
(lambda
  body: (block)? @function.inner
) @function.outside

(params
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(lambda
  params: ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(typeargs
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(typeparams
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(arguments
  positional: (positional_args
                ((_) @parameter.inner . ","? @parameter.outer)? @parameter.outer)
  ; TODO: get named args right
  named: (named_args ((_) @parameter.inner . ","? @parameter.outer)? @parameter.outer)
)

(
  (entity
    provides: (type (nominal_type name: (identifier) @_provides))
    members: (members) @test.inner
  ) @test.outside
  (#equal @_provides "UnitTest")
)

