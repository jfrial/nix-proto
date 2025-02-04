function(create_find_dependency dep)

  set(FIND_DEPENDENCY "")
  string(APPEND FIND_DEPENDENCY "if(NOT TARGET ${dep}::${dep})\n")
  string(APPEND FIND_DEPENDENCY "\tfind_dependency(${dep})\n")
  string(APPEND FIND_DEPENDENCY "endif()\n\n")

  set(FIND_DEPENDENCY_STRING
      "${FIND_DEPENDENCY}"
      PARENT_SCOPE)

endfunction()

function(set_depenencies deps)
  set(CPP_DEPS_LIST "${deps}")

  foreach(dep ${CPP_DEPS_LIST})
    find_package(${dep} REQUIRED)
    list(APPEND STATIC_DEPS ${dep}::${dep})
    list(APPEND SHARED_DEPS ${dep}::${dep}_shared)
    create_find_dependency(${dep})
    string(APPEND GENERATED_FIND_DEPENDENCY "${FIND_DEPENDENCY_STRING}")
  endforeach()
  set(STATIC_DEPS
      ${STATIC_DEPS}
      PARENT_SCOPE)
  set(SHARED_DEPS
      ${SHARED_DEPS}
      PARENT_SCOPE)
  set(GENERATED_FIND_DEPENDENCY
      ${GENERATED_FIND_DEPENDENCY}
      PARENT_SCOPE)

endfunction()
