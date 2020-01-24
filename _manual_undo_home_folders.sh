#!/bin/bash

for file in $(ls -A1 /home/cyber/); do mv -n -- "$file" "${file#_}"; done