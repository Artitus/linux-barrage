#!/bin/bash

# Print current users to a file

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 >> ./log/user-list

# TODO The rest of this file