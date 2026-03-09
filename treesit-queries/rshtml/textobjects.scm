(raw_block (html_text)? @entry.inner) @entry.outer

(section_block body: (_)? @entry.inner) @entry.outer

(rust_block content: (rust_text)? @entry.inner) @entry.outer


(if_stmt body: (_)? @entry.inner) @entry.outer

(while_stmt body: (_)? @entry.inner) @entry.outer

(for_stmt body: (_)? @entry.inner) @entry.outer

(match_stmt (match_stmt_arm) @entry.inner) 
(match_stmt (match_stmt_arm)+ @entry.inner) @entry.outer

(component_tag (component_tag_parameter (rust_identifier) @parameter.inner) @parameter.outer)
(component_tag body: (component_tag_body)? @entry.inner) @entry.outer

(comment_block (comment_content) @comment.inner) @comment.outer
