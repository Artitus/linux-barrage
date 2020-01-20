#!/bin/bash

cp_home_ext=(
    ico
    svg
    svgz
    qt
    abs
    jpeg
    jpg
    png
    gif
)
for x in ${cp_home_ext[*]}; do
    while IFS= read -r -d '' file; do
        $file | xargs -0 rm -rf  
    done < <(find /home/ -type f -name *.$x -print0)
done

cp_os_ext=(
    pcx
    pgm
    mp3
    mov
    mp4
    avi
    mpg
    mpeg
    flac
    m4a
    flv
    ogg
    midi
    mid
    mod
    mp2
    mpa
    mpega
    au
    snd
    wav
    aiff
    aif
    sid
    flac
    ogg
    mpeg
    mpg
    mpe
    dl
    movie
    movi
    mv
    iff
    anim5
    anim3
    anim7
    avi
    vfw
    avx
    fli
    flc
    mov
    spl
    swf
    dcr
    dxr
    rpm
    rm
    smi
    ra
    ram
    rv
    wmv
    asf
    asx
    wma
    wax
    wmv
    wmx
    3gp
    mov
    mp4
    avi
    swf
    flv
    m4v
    tiff
    tif
    im1
    rgb
    xwd
    xpm
    ppm
    pbm
)
for x in ${cp_os_ext[*]}; do
    while IFS= read -r -d '' file; do
        $file | xargs -0 rm -rf  
    done < <(find / -type f -name *.$x -print0)
done