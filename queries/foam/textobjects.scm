(dict) @class.outer
((dict_core) @class.inner)
((key_value value: _?  @function.inner._start (_)* _? @parameter.inner @function.inner._end)
    ) @function.outer
(code (_)* @class.inner) @class.outer
((comment)  @comment.outer._start ((comment)+)  @comment.outer._end
 )
(comment) @comment.inner

