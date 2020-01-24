#!/bin/bash

for u in $(cat log/user-list); do
    if [ ! "$u" = "$UserName" ]; then
        for file in $(ls -A1 /home/$u/); do 
            mv -n -- "$file" "${file#_}" 
        done
    fi
done