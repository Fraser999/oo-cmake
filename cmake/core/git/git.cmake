function(git)
  find_package(Git)
  if(NOT GIT_FOUND)
    message(FATAL_ERROR "missing git")
  endif()
  wrap_executable(git "${GIT_EXECUTABLE}")
  git(${ARGN})
  return_ans()


# old implementation

  cmake_parse_arguments("" "" "--cwd;RESULT;STDOUT;STDERR" "" ${ARGN})
  if(_--cwd)
    ref_set(__git_cached_cwd ${_--cwd})
    if(NOT EXISTS "${_--cwd}")
      message("creating git working dir '${_--cwd}'")
      file(MAKE_DIRECTORY "${_--cwd}")
    endif()
  else()
    ref_get(__git_cached_cwd)
    ans(__git_cached_cwd)
    set(_--cwd ${__git_cached_cwd})
  endif()


  set(args ${_UNPARSED_ARGUMENTS})
  if(NOT args)
    return()
  endif()
  find_package(Git)
  if(NOT GIT_FOUND)
    message(FATAL_ERROR "missing git")
  endif()

  message(INFO LEVEL 4 "executing git in directory  with args: ${args}")
   execute_process(
    COMMAND "${GIT_EXECUTABLE}" ${args} 
    WORKING_DIRECTORY "${_--cwd}"
    RESULT_VARIABLE error_code
   #OUTPUT_QUIET 
   #ERROR_QUIET
    OUTPUT_VARIABLE stdout
    ERROR_VARIABLE stderr
  )
   if(_STDOUT)
   #message("asdasd stdout ")
    set(${_STDOUT} ${stdout} PARENT_SCOPE)
   endif()
   if(_STDERR)
    set(${_STDERR} ${stderr} PARENT_SCOPE)
   endif()

   message(INFO LEVEL 8 "stdout:\n${stdout}")
   message(INFO LEVEL 4 "errorout:\n${stderr}")
  # message("stdout ${stdout}")
 # message(" ${stderr}")
   message(INFO LEVEL 4 "git returned ${error_code}")
   # if a result output is set then error code is retruned as result
   if(_RESULT)
    if(${error_code} EQUAL 0)
      set(${_RESULT} true PARENT_SCOPE)
    else()
      set(${_RESULT} false PARENT_SCOPE)
    endif()
    return()
   endif()
   # if not result is specified if git() fails an error will be thrown
   if(NOT "${error_code}" EQUAL 0)
    message(FATAL_ERROR "git failed to execute error output:\n${stderr}")
   endif()
endfunction()  