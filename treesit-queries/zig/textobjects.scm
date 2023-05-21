(TopLevelDecl (FnProto)
  (_) @function.inner) @function.outer

(TestDecl (_) @test.inner) @test.outer

; matches all of: struct, enum, union
; this unfortunately cannot be split up because
; of the way struct "container" types are defined
(TopLevelDecl (VarDecl (ErrorUnionExpr (SuffixExpr (ContainerDecl
    (_) @class.inner))))) @class.outer

(TopLevelDecl (VarDecl (ErrorUnionExpr (SuffixExpr (ErrorSetDecl
    (_) @class.inner))))) @class.outer

(ParamDeclList
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

[
  (doc_comment)
  (line_comment)
] @comment.inner
(line_comment)+ @comment.outer
(doc_comment)+ @comment.outer
