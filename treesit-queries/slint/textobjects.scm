(function_definition
  (imperative_block) @funtion.inner) @function.outer

(callback_event
  (imperative_block) @function.inner) @function.outer

(property
  (imperative_block) @function.inner) @function.outer

(struct_definition
  (struct_block) @class.inner) @class.outer

(enum_definition
  (enum_block) @class.inner) @class.outer

(global_definition
  (global_block) @class.inner) @class.outer

(component_definition
  (block) @class.inner) @class.outer

(component_definition
  (block) @class.inner) @class.outer

(comment) @comment.outer

(typed_identifier
  name: (_) @parameter.inner) @parameter.outer

(callback
  arguments: (_) @parameter.inner)

(string_value
  "\"" . (_) @text.inner . "\"") @text.outer

