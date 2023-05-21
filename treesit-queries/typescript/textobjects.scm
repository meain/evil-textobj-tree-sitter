; inherits: ecma

[
  (interface_declaration 
    body:(_) @class.inner)
  (type_alias_declaration 
    value: (_) @class.inner)
] @class.outer
