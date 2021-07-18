# rpi_deployment
Automated deployment of rpi

First run create_bootable_raspbian.sh - this script prepares the SD card with Wifi and Networking configured
Second run setup_remote_pi.sh - this configures users, change networking, hostname and install docker

## Steps
1. Download latest image
2. Decompress
3. Add bootfile
4. Copy the new image with IP via dd
5. Config wifi
6. Config networking
7. Use setup_remote_pi.sh script to configure initial values

`Usage:`
```
Usage: sudo ././create_bootable_raspbian.sh <SSID> <PSK> [-d|--download]

Options:
-d|--download : download and edit raspbian image in case of first run
```

## setup_remote_pi
1. Configure Wifi
1. Configure static IP for wlan0
1. Setup keyboard language
1. Create user atyu
1. Password atyu
1. Enable SSH
1. Enable i2c and spi for GPIO
1. Install vim
1. Install rpi.GPIO
1. Install docker - ToDo

Optional: disable user pi

