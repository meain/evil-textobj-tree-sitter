; Concerto Language - Text Object Queries (Helix)
; =================================================
; Helix-specific text objects. For use in helix-editor/helix at
; runtime/queries/concerto/textobjects.scm
;
; Helix uses @<object>.outer / @<object>.inner suffixes.
; See: https://docs.helix-editor.com/guides/textobject.html

; ---------------------------------------------------------------------------
; Classes / declarations
; ---------------------------------------------------------------------------
; mac / mic — select around/inside class
; ]c / [c   — jump to next/prev class boundary

(concept_declaration
  (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(asset_declaration
  (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(participant_declaration
  (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(transaction_declaration
  (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(event_declaration
  (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(enum_declaration
  (enum_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(map_declaration
  (map_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

; Scalar declarations have no body braces — around only
(scalar_declaration) @class.outer

; ---------------------------------------------------------------------------
; Comments
; ---------------------------------------------------------------------------
; ]C / [C — jump to next/prev comment
; maC / miC — select around/inside comment

(line_comment) @comment.inner
(block_comment) @comment.inner

(line_comment) @comment.outer
(block_comment) @comment.outer

; ---------------------------------------------------------------------------
; Parameters — fields, enum values, map entries
; ---------------------------------------------------------------------------
; ]a / [a — jump to next/prev parameter
; maa / mia — select around/inside parameter

(string_field) @parameter.inner
(boolean_field) @parameter.inner
(datetime_field) @parameter.inner
(integer_field) @parameter.inner
(long_field) @parameter.inner
(double_field) @parameter.inner
(object_field) @parameter.inner
(relationship_field) @parameter.inner
(enum_property) @parameter.inner
(map_key_type) @parameter.inner
(map_value_type) @parameter.inner
