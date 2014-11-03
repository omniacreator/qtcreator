################################################################################
# @file
# Propeller CMake
#
# @version @n 1.0
# @date @n 10/27/2014
#
# @author @n Kwabena W. Agyeman
# @copyright @n (c) 2014 Kwabena W. Agyeman
# @n All rights reserved - Please see the end of the file for the terms of use
#
# @par Update History:
# @n v1.0 - Original release - 5/24/2014
# @n v1.1 - Updated scripts - 10/27/2014
################################################################################

cmake_minimum_required(VERSION "2.8")
cmake_policy(VERSION "2.8")

# Test Args ####################################################################

if(NOT DEFINED IDE_FOLDER)
    message(FATAL_ERROR "IDE_FOLDER is not defined!")
endif()

if("${IDE_FOLDER}" STREQUAL "")
    message(FATAL_ERROR "IDE_FOLDER is empty!")
endif()

if(NOT DEFINED TOOLS_FOLDER)
    message(FATAL_ERROR "TOOLS_FOLDER is not defined!")
endif()

if("${TOOLS_FOLDER}" STREQUAL "")
    message(FATAL_ERROR "TOOLS_FOLDER is empty!")
endif()

if(NOT DEFINED USER_HOME_FOLDER)
    message(FATAL_ERROR "USER_HOME_FOLDER is not defined!")
endif()

if("${USER_HOME_FOLDER}" STREQUAL "")
    message(FATAL_ERROR "USER_HOME_FOLDER is empty!")
endif()

if(NOT DEFINED USER_DOCS_FOLDER)
    message(FATAL_ERROR "USER_DOCS_FOLDER is not defined!")
endif()

if("${USER_DOCS_FOLDER}" STREQUAL "")
    message(FATAL_ERROR "USER_DOCS_FOLDER is empty!")
endif()

if(NOT DEFINED CMAKE_FILE_PATHS)
    message(FATAL_ERROR "CMAKE_FILE_PATHS is not defined!")
endif()

if(NOT CMAKE_FILE_PATHS)
    message(FATAL_ERROR "CMAKE_FILE_PATHS is empty!")
endif()

if(NOT DEFINED LIBRARY_PATHS)
    message(FATAL_ERROR "LIBRARY_PATHS is not defined!")
endif()

if(NOT LIBRARY_PATHS)
    message(FATAL_ERROR "LIBRARY_PATHS is empty!")
endif()

if(NOT DEFINED PROJECT_FPATH)
    message(FATAL_ERROR "PROJECT_FPATH is not defined!")
endif()

if("${PROJECT_FPATH}" STREQUAL "")
    message(FATAL_ERROR "PROJECT_FPATH is empty!")
endif()

if(NOT DEFINED SERIAL_PORT)
    message(FATAL_ERROR "SERIAL_PORT is not defined!")
endif()

if(NOT DEFINED INCLUDE_SWITCH)
    message(FATAL_ERROR "INCLUDE_SWITCH is not defined!")
endif()

if(NOT DEFINED BOARD_ID)
    message(FATAL_ERROR "BOARD_ID is not defined!")
endif()

if("${BOARD_ID}" STREQUAL "")
    message(FATAL_ERROR "BOARD_ID is empty!")
endif()

if(NOT DEFINED MEMORY_MODEL)
    message(FATAL_ERROR "MEMORY_MODEL is not defined!")
endif()

if("${MEMORY_MODEL}" STREQUAL "")
    message(FATAL_ERROR "MEMORY_MODEL is empty!")
endif()

if(NOT DEFINED CLOCK_FREQ)
    set(CLOCK_FREQ "80000000")
endif()

if("${CLOCK_FREQ}" STREQUAL "")
    set(CLOCK_FREQ "80000000")
endif()

if(NOT DEFINED CLOCK_MODE)
    set(CLOCK_MODE "xtal1+pll16x")
endif()

if("${CLOCK_MODE}" STREQUAL "")
    set(CLOCK_MODE "xtal1+pll16x")
endif()

# Setup Toolchain ##############################################################

set(PROPELLER_SDK_PATH "${TOOLS_FOLDER}/propeller")

if(NOT "${INCLUDE_SWITCH}")

    set(CMAKE_TOOLCHAIN_FILE
    "${CMAKE_CURRENT_LIST_DIR}/propeller-cmake/cmake/PropellerToolchain.cmake")

    return()

endif()

# Link Directories #############################################################

# Omnia Creator User Libraries - 1st
# Omnia Creator System Libraries - 2nd

list(APPEND LIBRARY_PATHS
"${USER_DOCS_FOLDER}/SimpleIDE/Learn/Simple Libraries") # 3rd

list(APPEND LIBRARY_PATHS
"${PROPELLER_SDK_PATH}/Workspace/Learn/Simple Libraries") # 4th

foreach(LIBRARY_PATH ${LIBRARY_PATHS})

    link_directories("${LIBRARY_PATH}")

    get_filename_component(FOLDER_NAME "${LIBRARY_PATH}" NAME)

    if("${FOLDER_NAME}" STREQUAL "libraries")

        file(GLOB LIBRARIES RELATIVE "${LIBRARY_PATH}" "${LIBRARY_PATH}/*")

        foreach(LIBRARY ${LIBRARIES})
            if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}")

                # include_directories("${LIBRARY_PATH}/${LIBRARY}")

                # if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}/utility")
                #     include_directories("${LIBRARY_PATH}/${LIBRARY}/utility")
                # endif()

                # string(REGEX REPLACE "[^0-9A-Za-z]" "_" LIBRARY "${LIBRARY}")
                # set(${LIBRARY}_RECURSE TRUE)

            endif()
        endforeach()

    elseif("${FOLDER_NAME}" STREQUAL "Simple Libraries")

        file(GLOB LIBRARIES "${LIBRARY_PATH}/*")

        foreach(LIBRARY ${LIBRARIES})
            if(IS_DIRECTORY "${LIBRARY}")

                file(GLOB LIBS RELATIVE "${LIBRARY}" "${LIBRARY}/*")

                foreach(LIB ${LIBS})
                    if(IS_DIRECTORY "${LIBRARY}/${LIB}"
                    AND (NOT "${LIB}" STREQUAL "html") # HACK!!!
                    AND (NOT "${LIB}" STREQUAL "ActivityBot")) # HACK!!!

                        # include_directories("${LIBRARY}/${LIB}")

                        # if(IS_DIRECTORY "${LIBRARY}/${LIB}/source")
                        #     include_directories("${LIBRARY}/${LIB}/source")
                        # endif()

                        # string(REGEX REPLACE "[^0-9A-Za-z]" "_" LIB "${LIB}")
                        # set(${LIB}_RECURSE TRUE)

                    endif()
                endforeach()

            endif()
        endforeach()

    else()
        message(FATAL_ERROR "Unknown libs type \"${FOLDER_NAME}\"!")
    endif()

endforeach()

# Generate Propeller Firmware ##################################################

set(${PROJECT_NAME}_PORT "${SERIAL_PORT}")
set(${PROJECT_NAME}_BOARD "${BOARD_ID}")
set(${PROJECT_NAME}_MM "${MEMORY_MODEL}")
set(${PROJECT_NAME}_CF "${CLOCK_FREQ}")
set(${PROJECT_NAME}_CM "${CLOCK_MODE}")

if(IS_DIRECTORY "${PROJECT_FPATH}")

    file(GLOB SIDE_FILES
    "${PROJECT_FPATH}/*.side")

    if(SIDE_FILES)
        set(${PROJECT_NAME}_SIDE "${PROJECT_FPATH}")
    endif()

    file(GLOB_RECURSE SPIN_FILES
    "${PROJECT_FPATH}/*.spin")

    if(SPIN_FILES)
        set(${PROJECT_NAME}_SPIN ${SPIN_FILES})
    endif()

    file(GLOB_RECURSE SOURCE_FILES
    "${PROJECT_FPATH}/*.c"
    "${PROJECT_FPATH}/*.i"
    "${PROJECT_FPATH}/*.cpp"
    "${PROJECT_FPATH}/*.ii"
    "${PROJECT_FPATH}/*.cc"
    "${PROJECT_FPATH}/*.cp"
    "${PROJECT_FPATH}/*.cxx"
    "${PROJECT_FPATH}/*.c++"
    "${PROJECT_FPATH}/*.s"
    "${PROJECT_FPATH}/*.sx"
    "${PROJECT_FPATH}/*.cogc"
    "${PROJECT_FPATH}/*.cogcpp")

    if(SOURCE_FILES)
        set(${PROJECT_NAME}_SRCS ${SOURCE_FILES})
    endif()

    file(GLOB_RECURSE HEADER_FILES
    "${PROJECT_FPATH}/*.h"
    "${PROJECT_FPATH}/*.hpp"
    "${PROJECT_FPATH}/*.hh"
    "${PROJECT_FPATH}/*.hp"
    "${PROJECT_FPATH}/*.hxx"
    "${PROJECT_FPATH}/*.h++")

    if(HEADER_FILES)
        set(${PROJECT_NAME}_HDRS ${HEADER_FILES})
    endif()

else()

    get_filename_component(FILE_TYPE "${PROJECT_FPATH}" EXT)
    string(TOLOWER "${FILE_TYPE}" FILE_TYPE)

    if("${FILE_TYPE}" STREQUAL ".side")
        set(${PROJECT_NAME}_SIDE "${PROJECT_FPATH}")
    elseif("${FILE_TYPE}" STREQUAL ".spin")
        set(${PROJECT_NAME}_SPIN "${PROJECT_FPATH}")
    elseif(("${FILE_TYPE}" STREQUAL ".c")
    OR ("${FILE_TYPE}" STREQUAL ".i")
    OR ("${FILE_TYPE}" STREQUAL ".cpp")
    OR ("${FILE_TYPE}" STREQUAL ".ii")
    OR ("${FILE_TYPE}" STREQUAL ".cc")
    OR ("${FILE_TYPE}" STREQUAL ".cp")
    OR ("${FILE_TYPE}" STREQUAL ".cxx")
    OR ("${FILE_TYPE}" STREQUAL ".c++")
    OR ("${FILE_TYPE}" STREQUAL ".s")
    OR ("${FILE_TYPE}" STREQUAL ".sx")
    OR ("${FILE_TYPE}" STREQUAL ".cogc")
    OR ("${FILE_TYPE}" STREQUAL ".cogcpp"))
        set(${PROJECT_NAME}_SRCS "${PROJECT_FPATH}")
    elseif(("${FILE_TYPE}" STREQUAL ".h")
    OR ("${FILE_TYPE}" STREQUAL ".hpp")
    OR ("${FILE_TYPE}" STREQUAL ".hh")
    OR ("${FILE_TYPE}" STREQUAL ".hp")
    OR ("${FILE_TYPE}" STREQUAL ".hxx")
    OR ("${FILE_TYPE}" STREQUAL ".h++"))
        set(${PROJECT_NAME}_HDRS "${PROJECT_FPATH}")
    else()
        message(FATAL_ERROR "Unknown file type \"${FILE_TYPE}\"!")
    endif()

endif()

generate_propeller_firmware("${PROJECT_NAME}")

################################################################################
# @file
# @par MIT License - TERMS OF USE:
# @n Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# @n
# @n The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# @n
# @n THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
################################################################################
