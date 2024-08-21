; inherits: ecma

(interface_declaration) @class.outer

(interface_declaration
  body: (interface_body
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    _?  @class.inner._end
    .
    "}"
    ))

(type_alias_declaration) @class.outer

(type_alias_declaration
  value: (object_type
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    _?  @class.inner._end
    .
    "}"
    ))

(enum_declaration) @class.outer

(enum_declaration
  body: (enum_body
    .
    "{"
    .
    (_)  @class.inner._start  @class.inner._end
    _?  @class.inner._end
    .
    "}"
    ))

