(comment) @comment.inner

(comment)+ @comment.outer

(_
  brackets_open: _
  name: _?
  brackets_close: _
  _* @class.inner) @class.outer

(setting
  value: _? @function.inner) @function.outer

(graph_setting
  value: _? @function.inner) @function.outer

(graph_string_content
  (graph_task) @entry.inner)

(task_parameter
  ((_) @parameter.inner
    .
    ","? @parameter.outer) @parameter.outer)
