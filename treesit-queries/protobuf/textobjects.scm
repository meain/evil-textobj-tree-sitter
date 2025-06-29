(message (message_body) @class.inner) @class.outer
(enum (enum_body) @class.inner) @class.outer
(service (service_body) @class.inner) @class.outer

(rpc (message_or_enum_type) @parameter.inner) @function.inner
(rpc (message_or_enum_type) @parameter.outer) @function.outer

(comment) @comment.inner
(comment)+ @comment.outer
