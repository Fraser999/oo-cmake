
  function(string_decode_list str)
    string_semicolon_decode("${str}")
    ans(str)
    string_decode_bracket("${str}")
    ans(str)
   # message("decoded3: ${str}")
    return_ref(str)
  endfunction()