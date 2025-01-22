#!/bin/bash

LOCATION=$1

if [ ! $LOCATION ]; then
	read -p "Connect to where? " LOCATION
fi

if ! sudo openvpn /etc/openvpn/client/$LOCATION.protonvpn.udp.ovpn; then
	echo "Failed trying to connect the VPN"
	exit 1
fi
