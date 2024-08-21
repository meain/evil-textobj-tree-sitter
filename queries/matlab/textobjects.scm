(_
  (block) @block.inner) @block.outer

(block
  (_) @statement.outer)

(source_file
  (_) @statement.outer)

(function_call
  (arguments)? @call.inner) @call.outer

((arguments
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((arguments
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

(command) @call.outer

(command
  (command_argument) @parameter.inner @parameter.outer)

(command
  (command_argument)  @call.inner._start
  (command_argument)*  @call.inner._end
  .
  )

(if_statement
  (block) @conditional.inner) @conditional.outer

(if_statement
  (elseif_clause
    (block) @conditional.inner))

(if_statement
  (else_clause
    (block) @conditional.inner))

(switch_statement
  (case_clause
    (block) @conditional.inner)) @conditional.outer

(switch_statement
  (otherwise_clause
    (block) @conditional.inner))

(for_statement
  (block) @loop.inner) @loop.outer

(while_statement
  (block) @loop.inner) @loop.outer

(lambda
  expression: (_) @function.inner) @function.outer

(global_operator
  (identifier) @parameter.inner)

(persistent_operator
  (identifier) @parameter.inner)

(function_definition
  (block) @function.inner) @function.outer

(function_output
  (identifier) @parameter.inner @parameter.outer)

((function_arguments
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((function_arguments
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

((multioutput_variable
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((multioutput_variable
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

(try_statement
  (block) @conditional.inner) @conditional.outer

(catch_clause
  (identifier) @parameter.inner @parameter.outer)

(catch_clause
  (block) @conditional.inner)

(class_definition) @class.outer

(number) @number.inner

(_
  (return_statement) @return.inner @return.outer)

(comment) @comment.outer

(matrix
  (row) @parameter.outer)

(cell
  (row) @parameter.outer)

(row
  (_) @parameter.inner)

(assignment
  left: (_) @assignment.lhs
  (_) @assignment.rhs) @assignment.outer

((superclasses
  "&"?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((superclasses
  (_) @parameter.inner @parameter.outer._start
  .
  "&"  @parameter.outer._end)
  )

(enum
  (identifier) @parameter.inner @parameter.outer)

(property
  name: (_) @parameter.outer @parameter.inner)

((enum
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((enum
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

((validation_functions
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((validation_functions
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

((dimensions
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((dimensions
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

((attributes
  ","?  @parameter.outer._start
  .
  (_) @parameter.inner @parameter.outer._end .)
  )

((attributes
  (_) @parameter.inner @parameter.outer._start
  .
  ","  @parameter.outer._end)
  )

