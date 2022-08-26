(
 (exp_apply . (exp_name) . (_)  @call.inner._start . (_)* . (_)?  @call.inner._end .)
 
) @call.outer

(function rhs: (_) @function.inner) @function.outer
;; also treat function signature as @function.outer
(signature) @function.outer

(class) @class.outer
(class (class_body (where) _ @class.inner))
(instance (where)? . _ @class.inner) @class.outer

(comment) @comment.outer

