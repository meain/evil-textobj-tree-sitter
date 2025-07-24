(comment) @comment.inner

(comment)+ @comment.outer

(function
  body: (_) @function.inner) @function.outer

(args
  ((arg) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(call_args
  ((call_arg) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(map
  ((entry_inline) @entry.inner . ","? @entry.outer) @entry.outer)

(map_block
  ((entry_block) @entry.inner) @entry.outer)

(list
  ((element) @entry.inner . ","? @entry.outer) @entry.outer)

(tuple
  (_) @entry.outer)

(assign
  (meta (test))
  (function body: (_) @test.inner)
) @test.outer

(entry_block
  key: (meta (test))
  value: (function body: (_) @test.inner)
) @test.outer
