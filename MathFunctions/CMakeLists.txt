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
