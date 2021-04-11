#!/bin/bash

##########################
# Script wich does following:
# 1. Download rasbpian latest
# 2. Add file with init IP address
# 3. Copy with dd
##########################


RASPBIAN_URL="https://downloads.raspberrypi.org/raspbian_lite_latest"
CARD_DEV="sdb"

# 1. Download and decompress
if [ $# -gt 0 ]; then
    if [ $1 = "-d" ]; then
        curl -JLO $RASPBIAN_URL

        filename=$(ls | grep *raspbian*lite*)
        zipfilename=$filenamei.zip

        mv $filename $zipfilename

        echo $zipfilename
        unzip $zipfilename

    fi
fi

if [ ! -f *raspbian*lite.img ]; then
    echo "ERROR: File *raspban*lite.zip is not in current dir, use -d to download"
    exit 1
fi


# 3. Copy with dd

imgfilename=$(ls | grep *raspbian*lite*.img)
sudo dd if=$imgfilename of=/dev/$CARD_DEV bs=4M conv=fsync status=progress

echo "DONE"
exit 0
