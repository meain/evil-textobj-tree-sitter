; inherits: go

(style_element) @xml-element.outer
(style_element
  [(self_closing_style_tag) (style_element_text)] @xml-element.inner)

(script_element) @xml-element.outer
(script_element
  [(script_element_text) (self_closing_script_tag)] @xml-element.inner)

(element) @xml-element.outer
(element (self_closing_tag) @xml-element.inner)
(element (tag_start) (_)* @xml-element.inner (tag_end))

(element_comment) @comment.outer

(component_declaration
  (component_block) @function.inner) @function.outer

; TODO: function.inside textobjects
(css_declaration) @function.outer

(script_declaration
  (script_block) @function.inner) @function.outer
