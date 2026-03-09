[
  (function_definition
    [(function_rule) (function_fact)] @function.inner)
  (predicate_definition
    [(predicate_rule) (predicate_fact)] @function.inner)
  (actor_definition
    [(action_rule) (nonbacktrackable_predicate_rule)] @function.inner)
] @function.outer

(import_declaration
  (atom) @function.outer)

(parameters
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(arguments
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(comment) @comment.inner
(comment)+ @comment.outer

(array_expression
  (_) @entry.outer)

(list_expression
  (_) @entry.outer)
