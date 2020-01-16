#!/bin/bash

# USAGE
## log <module> <string to log>
log () {
    echo [$(date +%T)] $2 >> ./log/$1
}

# USAGE
## log <module> <string to log>
error () {
    echo [$(date +%T)] $2 >> ./log/$1-error
}

# USAGE Instead of actually deleting a file, just move it to an unscored position
## del <path/to/file/or/dir/to/remove>
del() {
    cp -r --parents $1 ./backup/
    rm -rf $1
}