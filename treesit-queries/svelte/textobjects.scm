(element (start_tag) (_)* @xml-element.inner (end_tag))

(element) @xml-element.outer

(comment) @comment.outer

(snippet_block
  parameters: (snippet_parameters) @parameter.inner) @function.outer

(snippet_name) @function.inner
