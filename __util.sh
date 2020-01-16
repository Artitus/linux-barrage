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