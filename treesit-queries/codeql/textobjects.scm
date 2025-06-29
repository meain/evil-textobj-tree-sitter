(qldoc) @comment.outer
(block_comment) @comment.outer
(line_comment) @comment.inner
(line_comment)+ @comment.outer

(classlessPredicate
  ((varDecl) @parameter.inner . ","?) @parameter.outer
  (body "{" (_)* @function.inner "}")) @function.outer
(memberPredicate
  ((varDecl) @parameter.inner . ","?) @parameter.outer
  (body "{" (_)* @function.inner "}")) @function.outer

(dataclass
  ("{" (_)* @class.inner "}")?) @class.outer
(datatype) @class.outer
(datatypeBranch) @class.outer
