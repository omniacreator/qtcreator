################################################################################
# @file
# Arduino CMake
#
# @version @n 1.0
# @date @n 10/25/2014
#
# @author @n Kwabena W. Agyeman
# @copyright @n (c) 2014 Kwabena W. Agyeman
# @n All rights reserved - Please see the end of the file for the terms of use
#
# @par Update History:
# @n v1.0 - Original release - 5/22/2014
# @n v1.1 - Updated scripts - 10/25/2014
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

# Setup Toolchain ##############################################################

if(NOT "${INCLUDE_SWITCH}")

    if(WIN32)
        set(CMAKE_COMPILER_IS_MINGW "1" CACHE INTERNAL "" FORCE)
    endif()

    set(ARDUINO_SDK_PATH "${TOOLS_FOLDER}/arduino" CACHE INTERNAL "" FORCE)

    set(CMAKE_TOOLCHAIN_FILE
    "${CMAKE_CURRENT_LIST_DIR}/arduino-cmake/cmake/ArduinoToolchain.cmake")

    return()

endif()

# Link Directories #############################################################

# Omnia Creator User Libraries - 1st
# Omnia Creator System Libraries - 2nd
list(APPEND LIBRARY_PATHS "${USER_DOCS_FOLDER}/Arduino/libraries") # 3rd
list(APPEND LIBRARY_PATHS "${ARDUINO_SDK_PATH}/libraries") # 4th

foreach(LIBRARY_PATH ${LIBRARY_PATHS})

    link_directories("${LIBRARY_PATH}")

    file(GLOB LIBRARIES RELATIVE "${LIBRARY_PATH}" "${LIBRARY_PATH}/*")

    foreach(LIBRARY ${LIBRARIES})
        if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}")

            include_directories("${LIBRARY_PATH}/${LIBRARY}")

            if(IS_DIRECTORY "${LIBRARY_PATH}/${LIBRARY}/utility")
                include_directories("${LIBRARY_PATH}/${LIBRARY}/utility")
            endif()

            string(REGEX REPLACE "[^0-9A-Za-z]" "_" LIBRARY "${LIBRARY}")
            set(${LIBRARY}_RECURSE TRUE)

        endif()
    endforeach()

endforeach()

# Include Directories - Omnia Creator C++ Support ##############################

if("${BOARD_ID}" STREQUAL "uno")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "diecimila")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "nano328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "nano")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "mega2560")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/mega")
elseif("${BOARD_ID}" STREQUAL "mega")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/mega")
elseif("${BOARD_ID}" STREQUAL "leonardo")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "esplora")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "micro")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/micro")
elseif("${BOARD_ID}" STREQUAL "mini328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "mini")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "ethernet")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "fio")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "bt328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "bt")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/eightanaloginputs")
elseif("${BOARD_ID}" STREQUAL "LilyPadUSB")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/leonardo")
elseif("${BOARD_ID}" STREQUAL "lilypad328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "lilypad")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro5v328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro5v")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro328")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "pro")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega168")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "atmega8")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/arduino"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/standard")
elseif("${BOARD_ID}" STREQUAL "robotControl")
    set(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/robot"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/robot_control")
elseif("${BOARD_ID}" STREQUAL "robotMotor")
    list(INCLUDE_PATHS
    "${ARDUINO_SDK_PATH}/hardware/arduino/cores/robot"
    "${ARDUINO_SDK_PATH}/hardware/arduino/variants/robot_motor")
else()
    message(FATAL_ERROR "Unknown board id \"${BOARD_ID}\"!")
endif()

foreach(INCLUDE_PATH ${INCLUDE_PATHS})

    include_directories("${INCLUDE_PATH}")

    file(GLOB INCLUDE_SUB_PATHS "${INCLUDE_PATH}/*")

    foreach(INCLUDE_SUB_PATH ${INCLUDE_SUB_PATHS})
        if(IS_DIRECTORY "${INCLUDE_SUB_PATH}")
            include_directories("${INCLUDE_SUB_PATH}")
        endif()
    endforeach()

endforeach()

# Add Definitions - Omnia Creator C++ Support ##################################

if(NOT DEFINED ARDUINO_SDK_VERSION_MAJOR)
    message(FATAL_ERROR "ARDUINO_SDK_VERSION_MAJOR is not defined!")
endif()

if("${ARDUINO_SDK_VERSION_MAJOR}" STREQUAL "")
    message(FATAL_ERROR "ARDUINO_SDK_VERSION_MAJOR is empty!")
endif()

if(NOT DEFINED ARDUINO_SDK_VERSION_MINOR)
    message(FATAL_ERROR "ARDUINO_SDK_VERSION_MINOR is not defined!")
endif()

if("${ARDUINO_SDK_VERSION_MINOR}" STREQUAL "")
    message(FATAL_ERROR "ARDUINO_SDK_VERSION_MINOR is empty!")
endif()

set(ARDUINO_VERSION_DEFINE "")

if("${ARDUINO_SDK_VERSION_MAJOR}" GREATER "0")
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}${ARDUINO_SDK_VERSION_MAJOR}")
endif()

if("${ARDUINO_SDK_VERSION_MINOR}" GREATER "9")
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}${ARDUINO_SDK_VERSION_MINOR}")
else()
    set(ARDUINO_VERSION_DEFINE
    "${ARDUINO_VERSION_DEFINE}0${ARDUINO_SDK_VERSION_MINOR}")
endif()

add_definitions("-DARDUINO=${ARDUINO_VERSION_DEFINE}")

if("${ARDUINO_VERSION_DEFINE}" GREATER "99")
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
else()
    message(FATAL_ERROR "Unknown board id \"${BOARD_ID}\"!")
endif()

# Generate Arduino Firmware ####################################################

set(${PROJECT_NAME}_PORT "${SERIAL_PORT}")
set(${PROJECT_NAME}_BOARD "${BOARD_ID}")

if(IS_DIRECTORY "${PROJECT_FPATH}")

    file(GLOB SKETCH_FILES
    "${PROJECT_FPATH}/*.ino"
    "${PROJECT_FPATH}/*.pde")

    if(SKETCH_FILES)
        set(${PROJECT_NAME}_SKETCH "${PROJECT_FPATH}")
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
    "${PROJECT_FPATH}/*.sx")

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

    if(("${FILE_TYPE}" STREQUAL ".ino")
    OR ("${FILE_TYPE}" STREQUAL ".pde"))
        set(${PROJECT_NAME}_SKETCH "${PROJECT_FPATH}")
    elseif(("${FILE_TYPE}" STREQUAL ".c")
    OR ("${FILE_TYPE}" STREQUAL ".i")
    OR ("${FILE_TYPE}" STREQUAL ".cpp")
    OR ("${FILE_TYPE}" STREQUAL ".ii")
    OR ("${FILE_TYPE}" STREQUAL ".cc")
    OR ("${FILE_TYPE}" STREQUAL ".cp")
    OR ("${FILE_TYPE}" STREQUAL ".cxx")
    OR ("${FILE_TYPE}" STREQUAL ".c++")
    OR ("${FILE_TYPE}" STREQUAL ".s")
    OR ("${FILE_TYPE}" STREQUAL ".sx"))
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

generate_arduino_firmware("${PROJECT_NAME}")

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
