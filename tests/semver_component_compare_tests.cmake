function(test)


  semver_component_compare("" "")
  ans(res)
  assert(${res} EQUAL 0)
  semver_component_compare("a" "")
  ans(res)
  assert(${res} EQUAL -1)
  semver_component_compare("" "a")
  ans(res)
  assert(${res} EQUAL 1)

  semver_component_compare(0 1)
  ans(res)
  assert(${res} EQUAL 1)
  semver_component_compare(1 2)
  ans(res)
  assert(${res} EQUAL 1)
  semver_component_compare(2 1)
  ans(res)
  assert(${res} EQUAL -1)
  semver_component_compare(1 1)
  ans(res)
  assert(${res} EQUAL 0)

  semver_component_compare(1 11)
  ans(res)
  assert(${res} EQUAL 1)

  semver_component_compare(2 11)
  ans(res)
  assert(${res} EQUAL 1)


  semver_component_compare(alpha rc1)
  ans(res)
  assert(${res} EQUAL 1)

  semver_component_compare(a 1)
  ans(res)
  assert(${res} EQUAL -1)
  semver_component_compare(1 a)
  ans(res)
  assert(${res} EQUAL 1)
  semver_component_compare(a a)
  ans(res)
  assert(${res} EQUAL 0)
  semver_component_compare(a b)
  ans(res)
  assert(${res} EQUAL 1)
  semver_component_compare(b a)
  ans(res)
  assert(${res} EQUAL -1)

endfunction()