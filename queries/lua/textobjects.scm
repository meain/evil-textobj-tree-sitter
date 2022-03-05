(function) @function.outer
(local_function) @function.outer
(function_definition) @function.outer

(for_in_statement) @loop.outer
(for_statement) @loop.outer
(while_statement) @loop.outer
(repeat_statement) @loop.outer

(if_statement) @conditional.outer

(function_call
  (arguments) @call.inner)
(function_call) @call.outer

(arguments
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
 )
(arguments
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

(parameters
  ","  @parameter.outer._start .
  (_) @parameter.inner @parameter.outer._end
 )
(parameters
  . (_) @parameter.inner @parameter.outer._start
  . ","?  @parameter.outer._end
 )

(arguments 
  . (table
    ","  @parameter.outer._start .
    (_) @parameter.inner @parameter.outer._end
   )
  . ) 
(arguments 
  . (table
    . (_) @parameter.inner @parameter.outer._start
    . ","?  @parameter.outer._end
   )
  . ) 

(comment) @comment.outer

((function
  . (function_name) . (parameters) . (_)  @function.inner._start
  (_)  @function.inner._end .)
 )
((local_function
  . (identifier) . (parameters) . (_)  @function.inner._start
  (_)  @function.inner._end .)
 )
((function_definition
  . (parameters) . (_)  @function.inner._start
  (_)  @function.inner._end .)
 )

((function
  . (function_name) . (parameters) . (_) @function.inner .))
((local_function
  . (identifier) . (parameters) . (_) @function.inner .))
((function_definition
  . (parameters) . (_) @function.inner .))

