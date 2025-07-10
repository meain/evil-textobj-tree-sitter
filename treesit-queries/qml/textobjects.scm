; (comment) is used for both // and /* ... */ comment syntax
(comment) @comment.inner
(comment)+ @comment.outer

(ui_object_definition
  initializer: (_) @class.inner) @class.outer

(ui_binding
  name: (identifier) @parameter.inner) @parameter.outer

(ui_property
  (_)+ @parameter.inner ":") @parameter.outer

(function_declaration
  body: (_) @function.inner) @function.outer

(arrow_function
  body: (_) @function.inner) @function.outer

; e.g. `onClicked: console.log("Button clicked!")`
((ui_binding
  name: (identifier) @_name
  value: (_) @function.outer @function.inner)
  (#match "^on[A-Z].*" @_name))

; e.g.
; Component.onCompleted: {
;    console.log("completed")
; }
(statement_block (expression_statement)* @function.inner) @function.outer

; e.g.
; states: [
;        State { name: "activated" },
;        State { name: "deactivated" }
; ]
(ui_object_array
  ((_) @entry.inner . ","? @entry.outer) @entry.outer)

; e.g. [1, 2, 3, 4]
(array
  ((_) @entry.inner . ","? @entry.outer) @entry.outer)

; Tests in QML are written using "Qt Quick Test" and it's `TestCase` type
; ref: https://doc.qt.io/qt-6/qtquicktest-index.html
((ui_object_definition
  type_name: (identifier) @_name
  initializer: (_) @test.inner) @test.outer
  (#equal @_name "TestCase"))
