

  function(ast_eval ast scope)
    if(ARGN)
      set(args ${ARGN})
      list_pop_front(language args)
      map_get(${language} evaluator_command_prefix evaluators)
     #ref_get(${evaluator_command_prefix} evaluator_command_prefix)
    else()
      if(NOT evaluator_command_prefix)
        message(FATAL_ERROR "no evaluator_command_prefix given")
      endif()
    endif()
    #message("evaluator prefix ${evaluator_command_prefix}... ${ARGN}")
    map_get(${ast} types types)
    map_isvalid("${evaluator_command_prefix}" ismap)
    while(true)
      list_pop_front(type types)
      if(NOT DEFINED type)
        break()
      endif()
      if(ismap)
        map_tryget(${evaluator_command_prefix} eval_command "${type}")
      else()
        set(eval_command "${evaluator_command_prefix}${type}")
      endif()
      if(COMMAND "${eval_command}")
        eval("${eval_command}(\"${ast}\" \"${scope}\")")
        ans(res)
        return_ans()
      endif()
    endwhile()
  endfunction()