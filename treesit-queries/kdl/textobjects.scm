(type (_) @test.inner) @test.outer

(node
	children: (node_children)? @class.inner) @class.outer

(node
	children: (node_children)? @function.inner) @function.outer

(node (identifier) @function.movement)

[
	(single_line_comment)
	(multi_line_comment)
] @comment.inner

[
	(single_line_comment)+
	(multi_line_comment)+
] @comment.outer

[
	(prop)
	(value)
] @parameter.inner

(value (type) ? (_) @parameter.inner @parameter.movement . ) @parameter.outer

