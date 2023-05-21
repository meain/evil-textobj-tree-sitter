
(declType (declClass (declSection) @class.inner)) @class.outer

(defProc body: (_) @function.inner) @function.outer

(declArgs (_) @parameter.inner) @parameter.outer
(exprArgs (_) @parameter.inner) @parameter.outer

(comment) @comment.inner
(comment)+ @comment.outer
