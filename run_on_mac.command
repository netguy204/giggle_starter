#!/usr/bin/env bash

PLATFORM=`uname`
HERE=`dirname "$0"`

export DYLD_LIBRARY_PATH=$HERE
(cd "$HERE" ; ./giggle/runtime-mac)
