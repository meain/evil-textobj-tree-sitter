[
  (integer_value)
  (float_value)
  (color_value)
] @number.inner

(declaration
  (property_name) @assignment.lhs
  .
  ":"
  .
  (_)  @assignment.rhs._start
  (_)?  @assignment.rhs._end
  .
  ";"
  
  ) @assignment.outer

(declaration
  (property_name) @assignment.inner)

