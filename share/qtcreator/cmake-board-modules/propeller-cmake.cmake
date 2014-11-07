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

if(WIN32)
    set(CMAKE_COMPILER_IS_MINGW "1") # Response File Bug Fix
endif()

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

link_directories(${LIBRARY_PATHS})

# Generate Propeller Firmware ##################################################

set(${PROJECT_NAME}_FPATH "${PROJECT_FPATH}")
set(${PROJECT_NAME}_MM "${MEMORY_MODEL}")
set(${PROJECT_NAME}_BOARD "${BOARD_ID}")
set(${PROJECT_NAME}_PORT "${SERIAL_PORT}")
set(${PROJECT_NAME}_CF "${CLOCK_FREQ}")
set(${PROJECT_NAME}_CM "${CLOCK_MODE}")

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
