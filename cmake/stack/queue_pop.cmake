
  function(queue_pop queue)
    ref_get(${queue} lst)
    list_pop_front(res lst)
    ref_set(${queue} "${lst}")
    string_decode_list("${res}")
    ans(decoded)
    return_ref(decoded)
  endfunction()
