; Function heads and guards have no body at all, so `keywords` and `do_block` nodes are both optional
((call
   target: (identifier) @_keyword
   (arguments
     [
       (call
         (arguments (_)? @parameter.inner))
       ; function has a guard
       (binary_operator
         left:
           (call
             (arguments (_)? @parameter.inner)))
     ]
     ; body is "do: body" instead of a do-block
     (keywords
       (pair
         value: (_) @function.inner))?)?
   (do_block (_)* @function.inner)?)
 (#match "^(def|defdelegate|defguard|defguardp|defmacro|defmacrop|defn|defnp|defp)$" @_keyword)) @function.outer

(anonymous_function
  (stab_clause right: (body) @function.inner)) @function.outer

((call
   target: (identifier) @_keyword
   (do_block (_)* @class.inner))
 (#match "^(defmodule|defprotocol|defimpl)$" @_keyword)) @class.outer

((call
  target: (identifier) @_keyword
  (arguments ((string) . (_)?))
  (do_block (_)* @test.inner)?)
 (#match "^(test|describe)$" @_keyword)) @test.outer

(comment)+ @comment.outer @comment.inner
