(function_definition
  body: (block)? @function.inner) @function.outer

(decorated_definition
  (function_definition) @function.outer) @function.outer.start

(class_definition
  body: (block)? @class.inner) @class.outer

(decorated_definition
  (class_definition) @class.outer) @class.outer.start

(while_statement
  body: (block)? @loop.inner) @loop.outer

(for_statement
  body: (block)? @loop.inner) @loop.outer

(if_statement
  alternative: (_ (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block)? @conditional.inner)

(if_statement
  condition: (_) @conditional.inner)

(_ (block) @block.inner) @block.outer
(comment) @comment.outer

(block (_) @statement.outer)
(module (_) @statement.outer)

(call) @call.outer
(call
  arguments: (argument_list . "(" . (_)  @call.inner._start (_)?  @call.inner._end . ")"
  ))

;; Parameters

((parameters
    ","  @parameter.outer._start .
    [
      (identifier)
      (tuple)
      (typed_parameter)
      (default_parameter)
      (typed_default_parameter)
      (dictionary_splat_pattern)
      (list_splat_pattern)
    ] @parameter.inner @parameter.outer._end
  )
  )

((parameters
    . [
      (identifier)
      (tuple)
      (typed_parameter)
      (default_parameter)
      (typed_default_parameter)
      (dictionary_splat_pattern)
      (list_splat_pattern)
    ] @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  
)

((lambda_parameters
    ","  @parameter.outer._start .
    [
      (identifier)
      (tuple)
      (typed_parameter)
      (default_parameter)
      (typed_default_parameter)
      (dictionary_splat_pattern)
      (list_splat_pattern)
    ] @parameter.inner @parameter.outer._end
  )
  )

((lambda_parameters
    . [
      (identifier)
      (tuple)
      (typed_parameter)
      (default_parameter)
      (typed_default_parameter)
      (dictionary_splat_pattern)
      (list_splat_pattern)
    ] @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

((tuple
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end
  )
  
)

((tuple
    "(" .
    (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  
)

((list
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end
  )
  
)

((list
    . (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

((dictionary
    . (pair) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

((dictionary
    ","  @parameter.outer._start . 
    (pair) @parameter.inner @parameter.outer._end
  )
  )

((argument_list
    . (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

((argument_list
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end
  )
  )

((subscript
    "[" . (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
  )
  )

((subscript
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end
  )
  )

[
  (integer)
  (float)
] @number.inner

(assignment
 left: (_) @assignment.lhs
 right: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assignment
 left: (_) @assignment.inner)

; TODO: exclude comments using the future negate syntax from tree-sitter

