; Function definitions (defn, defn-, defmacro, defmethod, etc.)
(list_lit
  .
  (sym_lit) @_keyword
  .
  (sym_lit)
  (_)* @function.inner
  (#match "^(defn|defn-|defmacro|defmethod|defmulti|definline)$" @_keyword)) @function.outer

; Anonymous functions (fn)
(list_lit
  .
  (sym_lit) @_fn
  (_)* @function.inner
  (#match "^fn$" @_fn)) @function.outer

; Anonymous function shorthand #()
(anon_fn_lit
  (_)* @function.inner) @function.outer

; deftype, defrecord, defprotocol
(list_lit
  .
  (sym_lit) @_keyword
  .
  (sym_lit)
  (_)* @class.inner
  (#match "^(deftype|defrecord|defprotocol|definterface|defstruct)$" @_keyword)) @class.outer

; Test definitions (deftest)
(list_lit
  .
  (sym_lit) @_keyword
  .
  (sym_lit)
  (_)* @test.inner
  (#match "^deftest$" @_keyword)) @test.outer

; Function parameters in vectors
(vec_lit
  (_)* @parameter.inner) @parameter.outer

; List entries
(list_lit
  (_) @entry.inner @entry.outer)

; Vector entries
(vec_lit
  (_) @entry.inner @entry.outer)

; Map entries
(map_lit
  (_) @entry.inner @entry.outer)

; Set entries
(set_lit
  (_) @entry.inner @entry.outer)

; Comments
(comment) @comment.inner
(comment)+ @comment.outer

; Discard expressions (also treated as comments)
(dis_expr) @comment.inner

; Comment special form (comment ...)
(list_lit
  .
  (sym_lit) @_comment
  (_)* @comment.inner
  (#match "^comment$" @_comment)) @comment.outer
