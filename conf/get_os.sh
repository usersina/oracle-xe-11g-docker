#!/bin/bash

case "$OSTYPE" in
    solaris*) echo "unix" ;; # SOLARIS
    darwin*)  echo "unix" ;; # OSX
    linux*)   echo "unix" ;; # LINUX
    bsd*)     echo "unix" ;; # BSD
    msys*)    echo "windows" ;; # WINDOWS
    cygwin*)  echo "windows" ;; # WINDOWS
    *)        echo "$OSTYPE" ;;
esac
