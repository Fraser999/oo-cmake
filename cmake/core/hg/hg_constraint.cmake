
 function(hg_constraint)
  package_query("${ARGN}")
  ans(pq)
  map_new()
  ans(constraint)
  nav(hg_constraint = pq.package_constraint)

  string_split_at_last(repo_uri branch "${hg_constraint}" "@")
  if(NOT branch)
    set(branch "default")
  endif()
  map_set(${constraint} uri "${repo_uri}")
  map_set(${constraint} "branch" ${branch})
  return (${constraint})
 endfunction()

function(hg_repository_name repository_uri)
  get_filename_component(repo_name "${repository_uri}" NAME_WE)
  return("${repo_name}")
endfunction()