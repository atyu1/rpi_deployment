#!/bin/bash

hostname=$1
ip=$2
dns=$3
ssid=$4
wifi_pass=$5
LOCALE=en_US.UTF-8
LAYOUT=us

if [ $# -eq 0 ]
 then
 echo "Usage> $0 <hostname> <ip with prefix> <dns/gw ip> <ssid> <wifi pass>"
 exit 1
fi

#change hostname
echo "# Changing hostname ..."
sudo hostnamectl --transient set-hostname $hostname
sudo hostnamectl --static set-hostname $hostname
sudo hostnamectl --pretty set-hostname $hostname

#static ip
echo "# Setup static IP..."
sudo cat <<EOT > /etc/network/interfaces
allow-hotplug wlan0
iface wlan0 inet static
	address $ip
	gateway $dns
	dns-nameservers $dns
	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
EOT

sudo systemctl disable dhcpcd
sudo systemctl enable networking
#wifi setup
echo "# Wifi setup..."
sudo cat <<EOT > /etc/wpa_supplicant/wpa_supplicant.conf 
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=SK

network={
  ssid="$ssid"
  psk="$wifi_pass"
}
EOT
sudo ip link set wlan0 up
sudo wpa_cli -i wlan0 reconfigure

echo "# Editing /etc/hosts..."
sudo cat << EOT > /etc/hosts
127.0.0.1	raspberrypi localhost 
$(echo $ip | cut -d"/" -f 1)	$hostname
EOT

#change language
echo "# Changing language..."
sudo raspi-config nonint do_change_locale $LOCALE 2> /dev/null
sudo raspi-config nonint do_configure_keyboard $LAYOUT 2> /dev/null

#set ssh
echo "# Enable ssh..."
sudo raspi-config nonint do_ssh 0

#set user atyu
echo "# Create user atyu ..."
sudo useradd -m -G sudo,spi,i2c,adm -s /bin/bash atyu
sudo passwd atyu

#disable user pi 
echo "# Disable user pi...."
sudo usermod -s /usr/bin/nologin pi
sudo passwd -l pi
