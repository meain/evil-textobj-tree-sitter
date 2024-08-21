(proc_declaration
  body: (_) @function.inner) @function.outer
(func_declaration
  body: (_) @function.inner) @function.outer
(iterator_declaration
  body: (_) @function.inner) @function.outer
(converter_declaration
  body: (_) @function.inner) @function.outer
(method_declaration
  body: (_) @function.inner) @function.outer
(template_declaration
  body: (_) @function.inner) @function.outer
(macro_declaration
  body: (_) @function.inner) @function.outer

(type_declaration (_) @class.inner) @class.outer

(parameter_declaration
  (symbol_declaration_list) @parameter.inner) @parameter.outer

[
  (comment)
  (block_comment)
  (documentation_comment)
  (block_documentation_comment)
] @comment.inner

[
  (comment)+
  (block_comment)
  (documentation_comment)+
  (block_documentation_comment)+
] @comment.outer
