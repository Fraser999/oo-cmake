function(keys_should_be_empty_for_new_object)
	obj_new()
  ans(obj)
	obj_keys(${obj} keys)
	assert(NOT keys)
endfunction()