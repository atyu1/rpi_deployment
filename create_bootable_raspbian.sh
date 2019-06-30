#!/bin/bash

##########################
# Script wich does following:
# 1. Download rasbpian latest
# 2. Add file with init IP address
# 3. Copy with dd
##########################

# 1. Download
if [ $# -gt 0 ]; then
    if [ $1 = "-d" ]; then
        curl -JLO https://downloads.raspberrypi.org/raspbian_lite_latest 
    fi
fi

if [ ! -f ./*raspbian*lite.zip ]; then
    echo "ERROR: File *raspban*lite.zip is not in current dir, use -d to download"
    exit 1
fi

# 2. Decompress it
filename=$(ls | grep *raspbian*lite.zip)
echo $filename
gunzip -S .zip $filename




echo "DONE"
exit 0
