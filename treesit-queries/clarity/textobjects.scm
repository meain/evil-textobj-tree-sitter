; Functions
(private_function
  (function_signature)
  (_) @function.inner) @function.outer

(read_only_function
  (function_signature)
  (_) @function.inner) @function.outer

(public_function
  (function_signature)
  (_) @function.inner) @function.outer

; FIXME: trait_definition not matching — may be a grammar issue
; (trait_definition) @class.outer

; Parameters
(function_signature
  (function_parameter) @parameter.inner @parameter.outer)

; Comments
(comment) @comment.inner
(comment)+ @comment.outer

; Entries
(local_binding) @entry.inner @entry.outer
