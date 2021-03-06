# removes every element from minuend thats in subtrahend
function(list_except minuend subtrahend)
	set(res)
	foreach(current ${minuend})
		list(FIND subtrahend "${current}" idx)
		if(${idx} LESS 0)
			list(APPEND res ${current})
		endif()
	endforeach()
  return_ref(res)
endfunction()