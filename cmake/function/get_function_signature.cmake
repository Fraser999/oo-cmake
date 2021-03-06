#
function(get_function_signature result func)
	get_function_lines(lines "${func}")
	#function_signature_regex(regex)
	foreach(line ${lines})
		string(REGEX MATCH "^[ ]*([mM][aA][cC][rR][oO]|[fF][uU][nN][cC][tT][iI][oO][nN])[ ]*\\([ \n\r]*([A-Za-z0-9_\\\\-]*)(.+)\\)" found "${line}")
		if(found)
			set(${result} "${line}" PARENT_SCOPE)
			return()
		endif()
	endforeach()
endfunction()