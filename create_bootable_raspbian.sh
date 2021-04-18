#!/bin/bash

##########################
# Script wich does following:
# 1. Download rasbpian latest
# 2. Add file with init IP address
# 3. Copy with dd
##########################


RASPBIAN_URL="https://downloads.raspberrypi.org/raspbian_lite_latest"
CARD_DEV="sdb"
IP="192.168.0.222"

SSID=$1
PSK=$2
IMAGE_FILE=""

echo $1 
echo $2

# 1. Download and decompress
if [ $# -gt 0 ]; then
    if [ $3 = "-d" ]; then
        curl -JLO $RASPBIAN_URL

        filename=$(ls | grep *raspbian*lite*)
        zipfilename=$filenamei.zip
        ipbootline="ip=$IP::255.255.255.0:192.168.0.1:rpi:eth0:off"

        mv $filename $zipfilename

        echo $zipfilename
        unzip $zipfilename

		# 2. Add Wifi details to img file

		IMAGE_FILE=$(ls | grep *raspbian*lite*.img)
        echo $IMAGE_FILE
		TMP=$(mktemp -d)
		LOOP=$(sudo losetup --show -fP "${IMAGE_FILE}")
		sudo mount ${LOOP}p2 $TMP
		sudo mount ${LOOP}p1 $TMP/boot/

        echo $TMP
		#create supplicant file
		cat << EOF >> $TMP/boot/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=SK

network={
 ssid="$SSID"
 psk="$PSK"
}
EOF

		touch $TMP/boot/ssh

		echo $ipbootline >> $TMP/boot/cmdline.txt

		# cleanup
		umount ${TMP}/boot/
		umount ${TMP}
		rmdir ${TMP}

    fi
fi

if [ ! -f *raspbian*lite.img ]; then
    echo "ERROR: File *raspban*lite.zip is not in current dir, use -d to download"
    exit 1
fi

# 3. Copy with dd
IMAGE_FILE=$(ls | grep *raspbian*lite*.img)

sudo dd if=$IMAGE_FILE of=/dev/$CARD_DEV bs=4M conv=fsync status=progress

echo "DONE"
exit 0
