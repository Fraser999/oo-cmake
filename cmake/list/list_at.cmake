function(list_at  lst idx)
  list(LENGTH ${lst} len)
  if(${idx} LESS 0)
    math(EXPR idx "${len} ${idx}")
  endif()
  list(GET ${lst} ${idx} value)
  return_ref(value)
endfunction()