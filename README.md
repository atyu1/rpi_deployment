# rpi_deployment
Automated deployment of rpi

## Steps
1. Download latest image
2. Decompress
3. Add bootfile
4. Copy the new image with IP via dd
5. Use setup_remote_pi.sh script to configure initial values

Add option to cmdline.txt
ip=192.168.0.22::255.255.255.0:192.168.0.1:rpi:eth0:off

## Create ansilbe playbook with
1. Configure Wifi
1. Configure static IP for wlan0
1. Setup keyboard language
1. Create user atyu
1. Password atyu
1. Enable SSH
1. Enable i2c and spi for GPIO
1. Install vim
1. Install rpi.GPIO
1. Install docker

Optional: disable user pi
8. 


## Scripts
