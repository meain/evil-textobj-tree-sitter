(comment) @comment.inner
(comment)+ @comment.outer

(directive
  name: (directive_name) @parameter.inner) @parameter.outer

(global_options
  "{" (_)* @class.inner "}") @class.outer

(snippet_definition
  (block) @class.inner) @class.outer

(named_route
  (block) @class.inner) @class.outer

(site_definition (block) @class.inner) @class.outer
