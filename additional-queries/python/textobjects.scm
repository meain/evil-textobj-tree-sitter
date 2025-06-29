(for_statement
 body: (_) @loop.inner) @loop.outer

(while_statement
 body: (_) @loop.inner) @loop.outer

(if_statement
 consequence: (_) @conditional.inner) @conditional.outer