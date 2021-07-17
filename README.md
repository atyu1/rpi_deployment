# rpi_deployment
Automated deployment of rpi

## Steps
1. Download latest image
2. Decompress
3. Add bootfile
4. Copy the new image with IP via dd
5. Config wifi
6. Config networking
7. Use setup_remote_pi.sh script to configure initial values

`ToDo:`
- Add IP address via option
- Make arguments more fancy
- Edit the code to split to functions for better readability

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

## Static RPI IP address

``` 
interface wlan0
static ip_address=192.168.0.201/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```


## Scripts
