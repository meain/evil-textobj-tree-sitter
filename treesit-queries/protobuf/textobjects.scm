(message (messageBody) @class.inner) @class.outer
(enum (enumBody) @class.inner) @class.outer
(service (serviceBody) @class.inner) @class.outer

(rpc (enumMessageType) @parameter.inner) @function.inner
(rpc (enumMessageType) @parameter.outer) @function.outer

(comment) @comment.inner
(comment)+ @comment.outer
