# Automate WiFi Connection on Wifi

I created this script because it was tedious to keep changing *wpa_supplicant.conf* when I wanted my RPi to connect to new wifi. Also *raspi-config* doesn't work
when there are spaces in WiFi name.

<img src="https://camo.githubusercontent.com/301d35c4fd5628d173333b4824a5648842408cee5cb545f8069c408e280bbabd/68747470733a2f2f63646e332e69636f6e66696e6465722e636f6d2f646174612f69636f6e732f6c6f676f732d616e642d6272616e64732d61646f62652f3531322f3237325f5261737062657272795f50692d3531322e706e67" width=200 alt="rpi-logo">

## Steps

1. Script will ask for Wifi's Name, Psk and Country of Origin
2. Will backup the *old wpa_supplicant.conf* in your home folder
3. Write a new wpa_supplicant.conf and reload the network service

## Extra

A comprehensive guide to set up headless can be found in this
[repository](https://github.com/sraodev/raspberry-pi-headless-setup)
