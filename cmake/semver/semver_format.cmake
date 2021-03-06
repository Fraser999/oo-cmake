 function(semver_format version)
  semver_normalize(${version})
  ans(version)
  map_format( "{version.major}.{version.minor}.{version.patch}")
  ans(res)
  nav("{version.prerelease}")
  ans(prerelease)
  if(DEFINED prerelease)
    set(res "${res}-${prerelease}")
  endif()

  nav("{version.metadata}")
  ans(metadata)
  if(DEFINED metadata)
    set(res "${res}+${metadata}")
  endif()

  return_ref(res)

 endfunction()