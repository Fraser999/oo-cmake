

function(cmake_string_to_json str)
  string(REPLACE "\\" "\\\\" str "${str}")


  string(REPLACE "\"" "\\\"" str "${str}")
  string(REPLACE "\n" "\\n" str "${str}")
  string(REPLACE "\t" "\\t" str "${str}")
  string(REPLACE "\t" "\\t" str "${str}")
  string(REPLACE "\r" "\\r" str "${str}")
  string(ASCII 8 bs)
  string(REPLACE "${bs}" "\\b" str "${str}")
  string(ASCII 12 ff)
  string(REPLACE "${ff}" "\\f" str "${str}")
  string(REPLACE ";" "\\\\;" str "${str}")
  set(str "\"${str}\"")
  return_ref(str)
endfunction()
