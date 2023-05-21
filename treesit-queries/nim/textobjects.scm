(routine
  (block) @function.inner) @function.outer

; @class.inner (types?)
; @class.outer

; paramListSuffix is strange and i do not understand it
(paramList
  (paramColonEquals) @parameter.inner) @parameter.outer

(comment) @comment.inner
(multilineComment) @comment.inner
(docComment) @comment.inner
(multilineDocComment) @comment.inner

(comment)+ @comment.outer
(multilineComment) @comment.outer
(docComment)+ @comment.outer
(multilineDocComment) @comment.outer
