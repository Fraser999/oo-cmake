function(obj_new)
	set(args ${ARGN})
	list_pop_front( args)
	ans(constructor)
	list(LENGTH constructor has_constructor)
	if(NOT has_constructor)
		set(constructor Object)
	endif()
	

	if(NOT COMMAND "${constructor}")
	
		message(FATAL_ERROR "obj_new: invalid type defined: ${constructor}, expected a cmake function")
	endif()

	type_get(${constructor})
	ans(base)
	map_get_special(${base} constructor)
	ans(constr)

	map_new()
	ans(instance)

	obj_setprototype(${instance} ${base})


	set(__current_constructor ${constructor})
	obj_callmember(${instance} __constructor__ ${args})
	ans(res)


	if(res)
		set(instance "${res}")
	endif()


	return_ref(instance)
endfunction()