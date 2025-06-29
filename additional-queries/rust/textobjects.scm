(loop_expression
  body: (_) @loop.inner) @loop.outer

(while_expression
  body: (_) @loop.inner) @loop.outer

(for_expression
  body: (_) @loop.inner) @loop.outer

(if_expression
  consequence: (_) @conditional.inner) @conditional.outer