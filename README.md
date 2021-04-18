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

## Scripts
