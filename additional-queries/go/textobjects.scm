(if_statement
  consequence: (block) @conditional.inner) @conditional.outer

(if_statement
  alternative: (block) @conditional.inner)? @conditional.outer

(expression_switch_statement
  (expression_case) @conditional.inner) @conditional.outer

(type_switch_statement
  (type_case) @conditional.inner) @conditional.outer

(select_statement
  (communication_case) @conditional.inner) @conditional.outer

(for_statement
  body: (block) @loop.inner) @loop.outer