;; "Classes"
(VarDecl 
  (_ (_ (ContainerDecl (ContainerMembers)? @class.inner)))) @class.outer

;; functions
(_ 
  (FnProto)
  (Block) @function.inner) @function.outer
