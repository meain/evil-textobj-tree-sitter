(class_def
  name: (_)
  (_) @class.inner) @class.outer

(struct_def
  name: (_)
  (_) @class.inner) @class.outer

(module_def
  name: (_)
  (_) @class.inner) @class.outer

(lib_def
  name: (_)
  (_) @class.inner) @class.outer

(enum_def
  name: (_)
  (_) @class.inner) @class.outer

(block
  params: (_) @parameter.inner) @parameter.outer

(method_def
  params: (_) @parameter.inner) @parameter.outer

(method_def
  name: (_)
  (_) @function.inner) @function.outer

(block
  (_) @function.inner) @function.outer

(comment) @comment.inner
(comment)+ @comment.outer

(array
  (_) @entry.outer)
