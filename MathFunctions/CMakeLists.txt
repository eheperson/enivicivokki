add_library(MathFunctions mysqrt.cxx)


# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )

# ---------------------- Installing Begin ----------------------
# specify install rules
# we want to install the library and header file and for the application 
# we want to install the executable and configured header.
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)

# ---------------------- Installing End ----------------------

# ---------------------- Adding System Introspection - Begin ----------------------
# adding some code to our project that depends on features the target platform may not have
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )
#
# does this system provide the log and exp functions?
include(CheckSymbolExists)
check_symbol_exists(log "math.h" HAVE_LOG)
check_symbol_exists(exp "math.h" HAVE_EXP)
if(NOT (HAVE_LOG AND HAVE_EXP))
    unset(HAVE_LOG CACHE)
    unset(HAVE_EXP CACHE)
    set(CMAKE_REQUIRED_LIBRARIES "m")
    check_symbol_exists(log "math.h" HAVE_LOG)
    check_symbol_exists(exp "math.h" HAVE_EXP)
    # if(HAVE_LOG AND HAVE_EXP)
    # target_link_libraries(MathFunctions PRIVATE m)
    # endif()
    if(HAVE_LOG AND HAVE_EXP)
        # If log and exp are available on the system, 
        # then we will use them to compute the square root in the mysqrt function
        target_compile_definitions(MathFunctions PRIVATE "HAVE_LOG" "HAVE_EXP")
    endif()
endif()
# ---------------------- Adding System Introspection - End ------------------------
