function(ref_prepend ref)
  get_property(value GLOBAL PROPERTY "${ref}")
  set_property( GLOBAL PROPERTY "${ref}" "${ARGN}" "${value}")
  return()
endfunction()