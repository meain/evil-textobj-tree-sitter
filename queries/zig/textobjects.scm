;; "Classes"
(VarDecl 
  (_ (_ (ContainerDecl) @class.inner))) @class.outer

;; functions
(_ 
  (FnProto)
  (Block) @function.inner) @function.outer

;; loops
(_
  (ForPrefix)
  (_) @loop.inner) @loop.outer

(_
  (WhilePrefix)
  (_) @loop.inner) @loop.outer

;; blocks
(_ (Block) @block.inner) @block.outer

;; statements
(Statement) @statement.outer

;; parameters
((ParamDeclList 
  ","  @parameter.outer._start . (ParamDecl) @parameter.inner @parameter.outer._end)
 ) 
((ParamDeclList
  . (ParamDecl) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 ) 

;; arguments
((FnCallArguments
  ","  @parameter.outer._start . (_) @parameter.inner @parameter.outer._end)
 ) 
((FnCallArguments
  . (_) @parameter.inner @parameter.outer._start . ","?  @parameter.outer._end)
 ) 

;; comments
(doc_comment) @comment.outer
(line_comment) @comment.outer

;; conditionals
(_
  (IfPrefix)
  (_) @conditional.inner) @conditional.outer

((SwitchExpr
  "{"  @conditional.inner._start "}"  @conditional.inner._end)
  )  @conditional.outer

;; calls
(_ (FnCallArguments) @call.inner) @call.outer

