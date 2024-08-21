; function.inside & around
; ------------------------

(static_function
  body: (_) @function.inner) @function.outer

(init_function
  body: (_) @function.inner) @function.outer

(bounced_function
  body: (_) @function.inner) @function.outer

(receive_function
  body: (_) @function.inner) @function.outer

(external_function
  body: (_) @function.inner) @function.outer

(function
  body: (_) @function.inner) @function.outer

; class.inside & around
; ---------------------

(struct
  body: (_) @class.inner) @class.outer

(message
  body: (_) @class.inner) @class.outer

(contract
  body: (_) @class.inner) @class.outer

; NOTE: Marked as @definition.interface in tags, as it's semantically correct
(trait
  body: (_) @class.inner) @class.outer

; parameter.inside & around
; -------------------------

(parameter_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(instance_argument_list
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

; comment.inside
; --------------

(comment) @comment.inner

; comment.around
; --------------

(comment)+ @comment.outer