(script_element (start_tag) (_) @xml-element.inner (end_tag))  @xml-element.outer

(style_element (start_tag) (_) @xml-element.inner (end_tag)) @xml-element.outer

(element (start_tag) (_)* @xml-element.inner (end_tag))

(element) @xml-element.outer

(comment) @comment.outer
