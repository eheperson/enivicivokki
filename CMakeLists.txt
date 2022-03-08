cmake_minimum_required(VERSION 3.22.2 FATAL_ERROR)

# set the project name and version
project(Enivicivokki VERSION 1.0.0)

# Options for packing
set(PACK_PACKAGE_VENDOR "eheperson")
set(CPACK_SYSTEM_NAME "enivicivokki")
set(PACKAGE_DIR "${CMAKE_SOURCE_DIR}/packing")
set(CPACK_PACKAGE_DIRECTORY "${PACKAGE_DIR}")
#
# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(EnivicivokkiConfig.h.in EnivicivokkiConfig.h)

# option to use custom module
option(USE_MYMATH "Use enivicivokki provided math implementation" ON)

# add the MathFunctions library
if(USE_MYMATH)
    # To make use  of the new library we will add an add_subdirectory() call
    add_subdirectory(MathFunctions)
    # use of the variable EXTRA_LIBS to collect up any optional libraries
    list(APPEND EXTRA_LIBS MathFunctions)
endif()


# add the executable
add_executable(${CMAKE_PROJECT_NAME} enivicivokki.cxx)

target_link_libraries(${CMAKE_PROJECT_NAME} PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find EnivicivokkiConfig.h
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

# ---------------------- Installing Begin ----------------------
# add the install targets
install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/EnivicivokkiConfig.h"
  DESTINATION include
  )
# ---------------------- Installing End ------------------------


# ---------------------- Test Begin ----------------------
enable_testing()
#
# does the application run
add_test(NAME Runs COMMAND ${CMAKE_PROJECT_NAME} 25)
#
# does the usage message work?
add_test(NAME Usage COMMAND ${CMAKE_PROJECT_NAME})
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
)
# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()
# do a bunch of result based tests
do_test(${CMAKE_PROJECT_NAME} 4 "4 is 2")
do_test(${CMAKE_PROJECT_NAME} 9 "9 is 3")
do_test(${CMAKE_PROJECT_NAME} 5 "5 is 2.236")
do_test(${CMAKE_PROJECT_NAME} 7 "7 is 2.645")
do_test(${CMAKE_PROJECT_NAME} 25 "25 is 5")
do_test(${CMAKE_PROJECT_NAME} -25 "-25 is (-nan|nan|0)")
do_test(${CMAKE_PROJECT_NAME} 0.0001 "0.0001 is 0.01")
# ---------------------- Test End ------------------------


# ---------------------- Packaging an Installer - Begin ----------------------
# to distribute our project to other people 
#
# This module will include any runtime libraries that are needed by the project 
# for the current platform
include(InstallRequiredSystemLibraries) 
#
# set some CPack variables to where we have stored the license and 
# version information for this project.
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "My funky project")
set(CPACK_PACKAGE_VENDOR ${CPACK_PACKAGE_VENDOR})

#
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
#
set(CPACK_PACKAGE_VERSION_MAJOR "${Enivicivokki_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Enivicivokki_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Enivicivokki_VERSION_PATCH}")
#
set(CPACK_PACKAGE_INSTALL_DIRECTORY "${APP_DIR} ${CMake_VERSION_MAJOR}.${CMake_VERSION_MINOR}.${CMake_VERSION_PATCH}")
#
if(WIN32 AND NOT UNIX)
  # There is a bug in NSI that does not handle full UNIX paths properly.
  # Make sure there is at least one set of four backlashes.
  set(CPACK_PACKAGE_ICON "${CMake_SOURCE_DIR}/Utilities/Release\\\\InstallIcon.bmp")
  set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\${P}.exe")
  set(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} My Ehe Project")
  set(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.enivicivokki.org")
  set(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.enivicivokki.com")
  set(CPACK_NSIS_CONTACT "ehe@enivicivokki.com")
  set(CPACK_NSIS_MODIFY_PATH ON)
else()
  set(CPACK_STRIP_FILES "bin/${CMAKE_PROJECT_NAME}")
  set(CPACK_SOURCE_STRIP_FILES "")
endif()
set(CPACK_PACKAGE_EXECUTABLES "${CMAKE_PROJECT_NAME}" "${CMAKE_PROJECT_NAME}")

#
set(CPACK_SOURCE_GENERATOR "TGZ")
#
include(CPack)
# ---------------------- Packaging an Installer - End ------------------------