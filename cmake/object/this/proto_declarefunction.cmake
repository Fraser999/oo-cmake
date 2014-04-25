function(proto_declarefunction result)
  obj_getprototype(${this})
  ans(proto)
	if(NOT proto)
		message(FATAL_ERROR "proto_declarefunction: expected prototype to be present")
	endif()
	set(res ${result})
  function_new()
  ans(func)
  obj_set("${proto}" "${result}" "${func}")
	#obj_declarefunction(${proto} ${res})
	set(${result} "${func}" PARENT_SCOPE)
endfunction()