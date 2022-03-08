cmake_minimum_required(VERSION 3.22.2 FATAL_ERROR)


# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

# option to use custom module
option(USE_MYMATH "Use tutorial provided math implementation" ON)

# add the MathFunctions library
if(USE_MYMATH)
    # To make use  of the new library we will add an add_subdirectory() call
    add_subdirectory(MathFunctions)
    # use of the variable EXTRA_LIBS to collect up any optional libraries
    list(APPEND EXTRA_LIBS MathFunctions)
endif()


# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

