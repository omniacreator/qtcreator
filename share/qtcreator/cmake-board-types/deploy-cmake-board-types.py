#!/usr/bin/env python

################################################################################
# @file
# Deploy CMake Board Types Script
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

import argparse, os, sys, shutil, fnmatch

INSTALL_FOLDER = "share/qtcreator/cmake-board-types"
SRC_FOLDER = ""

if __name__ == "__main__":

    __folder__ = os.path.dirname(os.path.abspath(__file__))

    parser = argparse.ArgumentParser(description =
    "Deploy CMake Board Types Script")

    parser.add_argument("install_folder", nargs = '?',
    default = os.getcwd())

    parser.add_argument("src_folder", nargs = '?',
    default = __folder__)

    args = parser.parse_args()

    install_folder = os.path.abspath(os.path.join(args.install_folder,
    INSTALL_FOLDER))

    src_folder = os.path.abspath(os.path.join(args.src_folder,
    SRC_FOLDER))

    if not os.path.exists(src_folder):
        sys.exit("Src Folder \"%s\" does not exist!" % src_folder)

    shutil.rmtree(install_folder, True)
    os.makedirs(install_folder)

    # Deploy ##################################################################

    files = []

    for dirpath, xxx, filenames in os.walk(src_folder):
        for filename in fnmatch.filter(filenames, "*.cmake"):
            files.append(os.path.relpath(os.path.join(dirpath, filename),
            src_folder))

    for file in files:
        install_file = os.path.join(install_folder, file)

        if not os.path.exists(os.path.dirname(install_file)):
            os.makedirs(os.path.dirname(install_file))

        shutil.copy2(os.path.join(src_folder, file), install_file)

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
