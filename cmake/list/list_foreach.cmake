

# executes action on each of lists elements
#function(list_foreach lst action)
#  foreach(item ${${lst}})
#    call(action("${item}"))
#  endforeach()
#endfunction()



function(list_foreach _action _query)
	#message(FATAL_ERROR "not supported currently")
	# import action function
	function_import("${_action}" as _map_foreach_action REDEFINE)

	# create a map that maps element name to container
	string_split( "${_query}" ",")
	ans(_query)
	element(MAP)
	foreach(_part ${_query})
		string(STRIP "${_part}" _part)
		string_split( "${_part}" " in ")
		ans(_def_parts)
		list(GET _def_parts 0 _name)
		list(GET _def_parts 1 _expr)
		value(KEY "${_name}" "${_expr}")
	endforeach()
	element(END _defs)

	#  setup bounds and indice list
	map_keys(${_defs} )
	ans(_def_keys)
	list(LENGTH _def_keys keys_length)
	set(_bounds)
	set(_indices)
	foreach(key ${_def_keys})
		map_get(${_defs}  ${key})
		ans(current_list)
		list(LENGTH ${current_list} _len)
		list(APPEND _bounds ${_len})
		list(APPEND _indices 0)

		# if any of the bounds is 0 then the loop is over
		if(${_len} LESS 1)
			return()
		endif()
	endforeach()

	math(EXPR keys_length "${keys_length} -1")
	set(_def_values)
	map_values(${_defs}  ${_def_keys})
	ans(_def_values)
	# iterate through all combinations of values
	while(true)
		# set values
		set(_current_values)
		foreach(i RANGE ${keys_length})
			list(GET _indices ${i} _current_index)
			list(GET _def_keys ${i} _current_key)
			list(GET _def_values ${i} _current_list)
			list(GET ${_current_list} ${_current_index} _current_value)
			list(APPEND _current_values ${_current_value})
			set(${_current_key} "${_current_value}")
		endforeach()

		# call action
		_map_foreach_action()

		# increment indices
		set(_overflow true)
		foreach(i RANGE ${keys_length})
			if(NOT _overflow)
				break()
			endif()
			set(_overflow false)
			list(GET _bounds ${i} _bound)
			list(GET _indices ${i} _index)
			math(EXPR _index "${_index} + 1")
			if(NOT ${_index} LESS ${_bound})
				set(_index 0)
				set(_overflow true)
			endif()
			list_replace_at(_indices ${i} ${_index})
		endforeach()
		if(_overflow)
			break()
		endif()
	endwhile()
	set(${result} "${res}" PARENT_SCOPE)
endfunction()