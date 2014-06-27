################################################################################
# @file
# Arduino CMake
#
# @version @n 1.0
# @date @n 5/22/2014
#
# @author @n Kwabena W. Agyeman
# @copyright @n (c) 2014 Kwabena W. Agyeman
# @n All rights reserved - Please see the end of the file for the terms of use
#
# @par Update History:
# @n v1.0 - Original release - 5/22/2014
################################################################################

cmake_minimum_required(VERSION 2.8)

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

# Setup Toolchain ##############################################################

if(DEFINED BEFORE_PROJECT_COMMAND AND NOT DEFINED AFTER_PROJECT_COMMAND)

    set(ENV{VERBOSE} TRUE)
    set(ENV{VERBOSE_SIZE} TRUE)

    set(ARDUINO_SDK_PATH
    ${TOOLS_FOLDER}/arduino)

    if(WIN32)
        set(CMAKE_MAKE_PROGRAM
        ${ARDUINO_SDK_PATH}/hardware/tools/avr/utils/bin/make.exe)
    endif()

    set(CMAKE_TOOLCHAIN_FILE
    ${CMAKE_CURRENT_LIST_DIR}/arduino-cmake/cmake/ArduinoToolchain.cmake)

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

# Generate Arduino Firmware ####################################################

get_filename_component(PROJECT_FILE_NAME ${PROJECT_FILE} NAME)
get_filename_component(PROJECT_PATH ${PROJECT_FILE} PATH)
get_filename_component(PROJECT_PATH_NAME ${PROJECT_PATH} NAME)
set(PROJECT_NAME ${PROJECT_FILE_NAME})

set(${PROJECT_NAME}_PORT ${SERIAL_PORT})
set(${PROJECT_NAME}_BOARD ${BOARD_ID})

file(GLOB SKETCH_FILES RELATIVE ${PROJECT_PATH}
*.ino *.pde)

if(SKETCH_FILES)
    set(${PROJECT_NAME}_SKETCH ${PROJECT_PATH})
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

generate_arduino_firmware(${PROJECT_NAME})

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
