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

cmake_policy(VERSION 2.8)

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

if(NOT DEFINED PROJECT_FOLDER)
    message(FATAL_ERROR "PROJECT_FOLDER is not defined!")
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

# Setup Toolchain ##############################################################

if(NOT ${INCLUDE_SWITCH})

    set(ARDUINO_SDK_PATH
    "${TOOLS_FOLDER}/arduino")

    set(CMAKE_TOOLCHAIN_FILE
    "${CMAKE_CURRENT_LIST_DIR}/arduino-cmake/cmake/ArduinoToolchain.cmake")

    return()

endif()

# Link Directories #############################################################

list(APPEND LIBRARY_PATHS "${ARDUINO_SDK_PATH}/libraries")

foreach(LIBRARY_PATH ${LIBRARY_PATHS})
    if(IS_DIRECTORY "${LIBRARY_PATH}")

        include_directories("${LIBRARY_PATH}")
        link_directories("${LIBRARY_PATH}")

        file(GLOB LIBRARYS RELATIVE "${LIBRARY_PATH}" "${LIBRARY_PATH}/*")

        foreach(LIBRARY ${LIBRARYS})
            if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}")

                include_directories("${LIBRARY_PATH}/${LIBRARY}")

                if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}/utility")
                    include_directories("${LIBRARY_PATH}/${LIBRARY}/utility")
                endif()

                string(REGEX REPLACE "[^0-9A-Za-z]" "_" LIBRARY "${LIBRARY}")
                set(${LIBRARY}_RECURSE TRUE)

            endif()
        endforeach()

    endif()
endforeach()

# Include Directories ##########################################################

if("${BOARD_ID}" STREQUAL "uno")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "diecimila")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "nano328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "nano")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "mega2560")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/mega")
elseif("${BOARD_ID}" STREQUAL "mega")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/mega")
elseif("${BOARD_ID}" STREQUAL "leonardo")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "esplora")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "micro")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/micro")
elseif("${BOARD_ID}" STREQUAL "mini328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "mini")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "ethernet")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "fio")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "bt328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "bt")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "LilyPadUSB")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "lilypad328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "lilypad")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro5v328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro5v")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro328")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega168")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega8")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "robotControl")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/robot"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/robot_control")
elseif("${BOARD_ID}" STREQUAL "robotMotor")
    list(APPEND INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/robot"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/robot_motor")
endif()

foreach(INCLUDE_PATH ${INCLUDE_PATHS})
    if(IS_DIRECTORY "${INCLUDE_PATH}")

        include_directories("${INCLUDE_PATH}")
        file(GLOB INCLUDE_SUB_PATHS "${INCLUDE_PATH}/*")

        foreach(INCLUDE_SUB_PATH ${INCLUDE_SUB_PATHS})
            if(IS_DIRECTORY "${INCLUDE_SUB_PATH}")
                include_directories("${INCLUDE_SUB_PATH}")
            endif()
        endforeach()

    endif()
endforeach()

# Add Definitions ##############################################################

set(ARDUINO_VERSION_DEFINE "")

if(ARDUINO_SDK_VERSION_MAJOR GREATER 0)
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}${ARDUINO_SDK_VERSION_MAJOR}")
endif()

if(ARDUINO_SDK_VERSION_MINOR GREATER 9)
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}${ARDUINO_SDK_VERSION_MINOR}")
else()
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}0${ARDUINO_SDK_VERSION_MINOR}")
endif()

add_definitions("-DARDUINO=${ARDUINO_VERSION_DEFINE}")

if(ARDUINO_VERSION_DEFINE GREATER 99)
    add_definitions("-DARDUINO_INCLUDE=<Arduino.h>")
else()
    add_definitions("-DARDUINO_INCLUDE=<WProgram.h>")
endif()

add_definitions("-DAVR=1" "-D__AVR=1" "-D__AVR__=1")

if("${BOARD_ID}" STREQUAL "uno")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "atmega328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "diecimila")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "nano328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "nano")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "mega2560")
    add_definitions("-D__AVR_ATmega2560__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "mega")
    add_definitions("-D__AVR_ATmega1280__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "leonardo")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=16000000L")
    add_definitions("-DUSB_VID=0x2341" "-DUSB_PID=0x8036")
elseif("${BOARD_ID}" STREQUAL "esplora")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=16000000L")
    add_definitions("-DUSB_VID=0x2341" "-DUSB_PID=0x803C")
elseif("${BOARD_ID}" STREQUAL "micro")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=16000000L")
    add_definitions("-DUSB_VID=0x2341" "-DUSB_PID=0x8037")
elseif("${BOARD_ID}" STREQUAL "mini328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "mini")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "ethernet")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "fio")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=8000000L")
elseif("${BOARD_ID}" STREQUAL "bt328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "bt")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "LilyPadUSB")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=8000000L")
    add_definitions("-DUSB_VID=0x1B4F" "-DUSB_PID=0x9208")
elseif("${BOARD_ID}" STREQUAL "lilypad328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=8000000L")
elseif("${BOARD_ID}" STREQUAL "lilypad")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=8000000L")
elseif("${BOARD_ID}" STREQUAL "pro5v328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "pro5v")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "pro328")
    add_definitions("-D__AVR_ATmega328P__=1" "-DF_CPU=8000000L")
elseif("${BOARD_ID}" STREQUAL "pro")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=8000000L")
elseif("${BOARD_ID}" STREQUAL "atmega168")
    add_definitions("-D__AVR_ATmega168__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "atmega8")
    add_definitions("-D__AVR_ATmega8__=1" "-DF_CPU=16000000L")
elseif("${BOARD_ID}" STREQUAL "robotControl")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=16000000L")
    add_definitions("-DUSB_VID=0x2341" "-DUSB_PID=0x8038")
elseif("${BOARD_ID}" STREQUAL "robotMotor")
    add_definitions("-D__AVR_ATmega32U4__=1" "-DF_CPU=16000000L")
    add_definitions("-DUSB_VID=0x2341" "-DUSB_PID=0x8039")
endif()

# Generate Arduino Firmware ####################################################

set(${PROJECT_NAME}_PORT "${SERIAL_PORT}")
set(${PROJECT_NAME}_BOARD "${BOARD_ID}")

file(GLOB SKETCH_FILES
"${PROJECT_FOLDER}/*.ino"
"${PROJECT_FOLDER}/*.pde")

if(SKETCH_FILES)
    set(${PROJECT_NAME}_SKETCH "${PROJECT_FOLDER}")
endif()

file(GLOB_RECURSE SOURCE_FILES
"${PROJECT_FOLDER}/*.c"
"${PROJECT_FOLDER}/*.i"
"${PROJECT_FOLDER}/*.cpp"
"${PROJECT_FOLDER}/*.ii"
"${PROJECT_FOLDER}/*.cc"
"${PROJECT_FOLDER}/*.cp"
"${PROJECT_FOLDER}/*.cxx"
"${PROJECT_FOLDER}/*.c++"
"${PROJECT_FOLDER}/*.s"
"${PROJECT_FOLDER}/*.sx")

if(SOURCE_FILES)
    set(${PROJECT_NAME}_SRCS ${SOURCE_FILES})
endif()

file(GLOB_RECURSE HEADER_FILES
"${PROJECT_FOLDER}/*.h"
"${PROJECT_FOLDER}/*.hpp"
"${PROJECT_FOLDER}/*.hh"
"${PROJECT_FOLDER}/*.hp"
"${PROJECT_FOLDER}/*.hxx"
"${PROJECT_FOLDER}/*.h++")

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
