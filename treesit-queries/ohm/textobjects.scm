; See: https://docs.helix-editor.com/guides/textobject.html

; function.inside & around
; ------------------------

(rule
  body: (_) @function.inner) @function.outer

; class.inside & around
; ---------------------

(grammar
  body: (_) @class.inner) @class.outer

; parameter.inside & around
; -------------------------

(formals
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(rule_body
  ((_) @parameter.inner . "|"? @parameter.outer) @parameter.outer)

(params
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(alt
  ((_) @parameter.inner . "|"? @parameter.outer) @parameter.outer)

; comment.inside
; --------------

(multiline_comment)+ @comment.inner
(singleline_comment)+ @comment.inner

; comment.around
; --------------

(multiline_comment)+ @comment.outer
(singleline_comment)+ @comment.outer
