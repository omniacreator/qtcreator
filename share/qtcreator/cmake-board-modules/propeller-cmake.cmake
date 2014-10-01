################################################################################
# @file
# Propeller CMake
#
# @version @n 1.0
# @date @n 5/24/2014
#
# @author @n Kwabena W. Agyeman
# @copyright @n (c) 2014 Kwabena W. Agyeman
# @n All rights reserved - Please see the end of the file for the terms of use
#
# @par Update History:
# @n v1.0 - Original release - 5/24/2014
################################################################################

cmake_minimum_required(VERSION 2.8)

message(FATAL_ERROR "Propeller Chip support is not fully operational yet...")

return()

# Test Args ####################################################################

if(NOT DEFINED IDE_FOLDER)
    message(FATAL_ERROR "IDE_FOLDER is not defined!")
endif()

if(NOT DEFINED TOOLS_FOLDER)
    message(FATAL_ERROR "TOOLS_FOLDER is not defined!")
endif()

if(NOT DEFINED CMAKE_FILE_PATHS)
    message(FATAL_ERROR "CMAKE_FILE_PATHS is not defined!")
endif()

if(NOT DEFINED LIBRARY_PATHS)
    message(FATAL_ERROR "LIBRARY_PATHS is not defined!")
endif()

if(NOT DEFINED PROJECT_FILE)
    message(FATAL_ERROR "PROJECT_FILE is not defined!")
endif()

if(NOT DEFINED SERIAL_PORT)
    message(FATAL_ERROR "SERIAL_PORT is not defined!")
endif()

if(NOT DEFINED BOARD_ID)
    message(FATAL_ERROR "BOARD_ID is not defined!")
endif()

if(NOT DEFINED MEMORY_MODEL)
    message(FATAL_ERROR "MEMORY_MODEL not defined!")
endif()

if(NOT DEFINED CLOCK_FREQ)
    set(CLOCK_FREQ "80000000")
endif()

if(NOT DEFINED CLOCK_MODE)
    set(CLOCK_MODE "xtal1+pll16x")
endif()

# Setup Toolchain ##############################################################

if(DEFINED BEFORE_PROJECT_COMMAND AND NOT DEFINED AFTER_PROJECT_COMMAND)

    set(ENV{VERBOSE} TRUE)
    set(ENV{VERBOSE_SIZE} TRUE)

    set(PROPELLER_SDK_PATH
    ${TOOLS_FOLDER}/propeller)

    set(CMAKE_TOOLCHAIN_FILE
    ${CMAKE_CURRENT_LIST_DIR}/propeller-cmake/cmake/PropellerToolchain.cmake)

    return()

endif()

# Link Directories #############################################################

foreach(LIBRARY_PATH ${LIBRARY_PATHS})

    file(GLOB LIBRARYS RELATIVE ${LIBRARY_PATH} *)

    foreach(LIBRARY ${LIBRARYS})
        if(IS_DIRECTORY ${LIBRARY_PATH}/${LIBRARY})
            link_directories(${LIBRARY_PATH}/${LIBRARY})
            string(REGEX REPLACE "[^0-9A-Za-z]" "_" LIBRARY ${LIBRARY})
            set(${LIBRARY}_RECURSE TRUE)
        endif()
    endforeach()

endforeach()

# Generate Propeller Firmware ##################################################

get_filename_component(PROJECT_FILE_NAME ${PROJECT_FILE} NAME)
get_filename_component(PROJECT_PATH ${PROJECT_FILE} PATH)
get_filename_component(PROJECT_PATH_NAME ${PROJECT_PATH} NAME)
set(PROJECT_NAME ${PROJECT_FILE_NAME})

set(${PROJECT_NAME}_PORT ${SERIAL_PORT})
set(${PROJECT_NAME}_BOARD ${BOARD_ID})
set(${PROJECT_NAME}_MM ${MEMORY_MODEL})

set(${PROJECT_NAME}_CF ${CLOCK_FREQ})
set(${PROJECT_NAME}_CM ${CLOCK_MODE})

file(GLOB SIDE_FILES RELATIVE ${PROJECT_PATH}
*.side)

if(SIDE_FILES)
    set(${PROJECT_NAME}_SIDE ${SIDE_FILES})
endif()

file(GLOB SPIN_FILES RELATIVE ${PROJECT_PATH}
*.spin)

if(SPIN_FILES)
    set(${PROJECT_NAME}_SPIN ${SPIN_FILES})
endif()

file(GLOB COGC_FILES RELATIVE ${PROJECT_PATH}
*.cogc *.cogcpp)

if(COGC_FILES)
    set(${PROJECT_NAME}_COGC ${COGC_FILES})
endif()

file(GLOB SOURCE_FILES RELATIVE ${PROJECT_PATH}
*.c *.i *.cpp *.ii *.cc *.cp *.cxx *.c++ *.s *.sx)

if(SOURCE_FILES)
    set(${PROJECT_NAME}_SRCS ${SOURCE_FILES})
endif()

file(GLOB HEADER_FILES RELATIVE ${PROJECT_PATH}
*.h *.hpp *.hh *.hp *.hxx *.h++)

if(HEADER_FILES)
    set(${PROJECT_NAME}_HDRS ${HEADER_FILES})
endif()

generate_propeller_firmware(${PROJECT_NAME})

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
