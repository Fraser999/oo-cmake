macro(obj_callmember ref key)
	obj_nullcheck(${ref})
	obj_get(${ref} func ${key})
	#message(${func})
	eval(${func})
	obj_bindcall(${ref} ${key} ${ARGN})
endmacro()