# iterates a the graph with root nodes in ${ARGN}
# in depth first order
# expand must consider cycles
function(dfs expand)
  stack_new()
  ans(stack)
  curry(stack_push("${stack}" /1))
  ans(push)
  curry(stack_pop("${stack}" ))
  ans(pop)
  graphsearch(EXPAND "${expand}" PUSH "${push}" POP "${pop}" ${ARGN})
endfunction()
