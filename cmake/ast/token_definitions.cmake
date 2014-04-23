# returns the token definitions of a language 
function(token_definitions language)
  map_get(${language} definitions definitions)
  map_keys(${definitions} keys)
  set(token_definitions)
  foreach(key ${keys})
    map_get(${definitions} definition ${key})
    map_tryget(${definition} parser parser)
    if("${parser}" STREQUAL "token")
      map_set(${definition} name "${key}")
      map_tryget(${definition} regex regex)
      if(regex)
        map_set(${token_definition} regex "${regex}")
      else()
        map_tryget(${definition} match match)
        string_regex_escape("${match}")
        ans(match)
        map_set(${definition} regex "${match}")
      endif()
      list(APPEND token_definitions ${definition})
    endif()
  endforeach()
  return_ref(token_definitions)
endfunction()