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

(call) @call.outer
(call (_) @call.inner)

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

; TODO: exclude comments using the future negate syntax from tree-sitter

