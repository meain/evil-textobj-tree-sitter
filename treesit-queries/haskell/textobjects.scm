(comment) @comment.inner
(comment)+ @comment.outer

(newtype
	(newtype_constructor
		(_) @class.inner)) @class.outer
(data_type
	constructors: (_) @class.inner) @class.outer
(decl/function
	(match expression:(_) @function.inner)) @function.outer
(lambda
	expression:(_) @function.inner) @function.outer

(decl/function
	patterns: (patterns
		(_) @parameter.inner))

(expression/lambda
	patterns: (patterns
	(_) @parameter.inner))

(decl/function
	(infix
		(pattern) @parameter.inner))
