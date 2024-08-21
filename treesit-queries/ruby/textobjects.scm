; Class and Modules
(class
  body: (_)? @class.inner) @class.outer

(singleton_class
  value: (_)
  (_)+ @class.inner) @class.outer

(call
  receiver: (constant) @class_const
  method: (identifier) @class_method
  (#match "Class" @class_const)
  (#match "new" @class_method)
  (do_block (_)+ @class.inner)) @class.outer
  
(module
  body: (_)? @class.inner) @class.outer

; Functions and Blocks
(singleton_method
  body: (_)? @function.inner) @function.outer

(method
  body: (_)? @function.inner) @function.outer

(do_block
  body: (_)? @function.inner) @function.outer

(block
  body: (_)? @function.inner) @function.outer

; Parameters      
(method_parameters
  (_) @parameter.inner) @parameter.outer
        
(block_parameters 
  (_) @parameter.inner) @parameter.outer
        
(lambda_parameters 
  (_) @parameter.inner) @parameter.outer

; Comments
(comment) @comment.inner 
(comment)+ @comment.outer

(pair
  (_) @entry.inner) @entry.outer

(array
  (_) @entry.outer)

(string_array
  (_) @entry.outer)

(symbol_array
  (_) @entry.outer)
