#imports a function from a file
#

function(import_function)
  set(options REDEFINE ONCE)
  set(oneValueArgs as)
  set(multiValueArgs)
  set(prefix)
  cmake_parse_arguments("${prefix}" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})


  if(NOT _UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "missing function to import")
  endif()

  list(LENGTH _UNPARSED_ARGUMENTS arg_count)

  if(${arg_count} LESS 1)  
    message(FATAL_ERROR "invalid usage of import_function")
  endif()

  list(GET _UNPARSED_ARGUMENTS 0 func)
  #message("${_UNPARSED_ARGUMENTS}")
  set(function_name ${_as})


  # get function implementation this fails if func is not a function
  get_function_string(function_string "${func}")

  string(MD5 hash "${function_string}")
  if(EXISTS "${cutil_cache_dir}/${hash}")
    include ("${cutil_cache_dir}/${hash}")
   # message("cached found ${func} at ${cutil_cache_dir}/${hash}:0")
    return()
  endif()
  parse_function(func "${function_string}")

  if(NOT function_name)
    set(function_name "${func_name}")
  endif()


  debug_message("importing function ${func_name} as ${function_name}")
#print_locals()
  #message(FATAL_ERROR "name ${func_name}")

  #message("function is ${func_type} named ${func_name} with args: ${func_args}")

  # code which is run everytime a function is called
  if(show_debug)
    set(on_call 
    "set(imported_caller_function_name ${imported_function_name})
    set(imported_function_name ${function_name})")
  endif()
  # add profiling code if performance counts is on
  if(performance_counts)
    set(on_call "${on_call} \n function_called(\"${function_name}\" \"\${imported_caller_function_name}\")") 
  endif()


  #code which is run once when a function is defined
  set(before_function 
    "#debug_message(\"imported ${function_name}  \")"
  )

  if(COMMAND "${function_name}" AND NOT _REDEFINE)
    if(_ONCE)
      debug_message("returning because '${function_name}' was already imported")
      return()
    endif()
    message(FATAL_ERROR "cannot import ${function_name} because it already exists")
  endif()



  inject_function(function_string  "${function_string}" ON_CALL "${on_call}" BEFORE_FUNCTION "${before_function}" RENAME "${function_name}")

  file(WRITE "${cutil_cache_dir}/${hash}" "${function_string}")
  #message("import_function ${function_string}" )
  import_function_string("${function_string}")
 
  

endfunction()