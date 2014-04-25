function(language_load definition_file)
  if(NOT EXISTS "${definition_file}")
    return()
  endif()
  file(READ "${definition_file}" data)

  json_deserialize( "${data}")
  ans(language)
  string(MD5 hash "${data}")
  map_set(${language} md5 "${hash}")
 # ref_print(${language})
  if(NOT language)
    return()
  endif()
  language_initialize(${language})

  return_ref(language)
endfunction()
