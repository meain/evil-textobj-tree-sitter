(atom_block
  (atom) @entry.inner) @entry.outer

(email_address) @entry.outer
(header_other
  (header_unstructured) @entry.outer)

(quoted_block)+ @comment.outer

(body_block)+ @function.outer

(header_subject
  (subject) @function.outer)
