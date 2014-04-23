
function(string_normalize_index str index)

  set(idx ${index})
  string(LENGTH "${str}" length)
  if(${idx} LESS 0)
    math(EXPR idx "${length} ${idx} + 1")
  endif()
  if(${idx} LESS 0)
    #message(WARNING "index out of range: ${index} (${idx}) length of string '${str}': ${length}")
    return(-1)
  endif()

  if(${idx} GREATER ${length})
    #message(WARNING "index out of range: ${index} (${idx}) length of string '${str}': ${length}")
    return(-1)
  endif()
  return(${idx})
endfunction()