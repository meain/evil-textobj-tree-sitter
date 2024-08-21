(type_definition) @class.outer

(executable_definition) @function.outer

(arguments_definition
  (input_value_definition) @parameter.inner @parameter.movement)

(arguments
  (argument) @parameter.inner @parameter.movement)

(selection
  [(field) (fragment_spread)] @entry.outer)

(selection
  (field (selection_set) @entry.inner))

(field_definition
  (_) @entry.inner) @entry.outer

(input_fields_definition
  (input_value_definition ) @entry.outer)

(enum_value) @entry.outer
