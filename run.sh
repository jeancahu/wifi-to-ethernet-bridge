#!/bin/bash

## Request dependences
which dhcpd &>/dev/null || {
    which apt &>/dev/null && echo "Install the isc-dhcp-server package with:
sudo apt-get update
sudo apt-get install isc-dhcp-server"

    which pacman &>/dev/null && echo "Install the dhcp package with:
sudo pacman -Sy dhcp"
    exit 1
}

which fzf &>/dev/null || {
    which apt &>/dev/null && echo "Install the fzf package with:
sudo apt-get update
sudo apt-get install fzf"

    which pacman &>/dev/null && echo "Install the fzf package with:
sudo pacman -Sy fzf"
    exit 1
}

## Declare interfaces
declare eth_interface=$(
    ip -o -N link show | awk -F': ' '{print $2}' |
        grep -e "^e" |
        fzf -i --header='Select an ethernet interface:'
        )
declare wi_interface=$(
    ip -o -N link show | awk -F': ' '{print $2}' |
        grep -e "^w" |
        fzf -i --header='Select a wireless interface:'
        )

## Set up the ethernet interface
ip link show $eth_interface
ip link set $eth_interface down
ip addr add 10.5.5.1/24 dev $eth_interface &>/dev/null
ip link set $eth_interface up; sleep 2

if (( $( ip link show $eth_interface | grep -c ' DOWN ' ) ))
   then
       echo "Failed getting $eth_interface interface up"
       exit 2
fi

set -e

## Set forward to the wireless interface
sysctl -w net.ipv4.ip_forward=1
iptables -A FORWARD -i $eth_interface -o $wi_interface -j ACCEPT
iptables -t nat -A POSTROUTING -o $wi_interface -j MASQUERADE

## Run the dhcp server
cat >/tmp/tmp_dhcpd.conf <<< "
## Write temporal DHCPD configuration
default-lease-time 600;
max-lease-time 7200;
ddns-update-style none;
option dhcp-interface-name ${eth_interface};

shared-network ${eth_interface}-subnet {
    subnet 10.5.5.0 netmask 255.255.255.0 {
        range 10.5.5.100 10.5.5.200;
        option routers 10.5.5.1;
        option subnet-mask 255.255.255.0;
        option broadcast-address 10.5.5.255;
        # Google DNS:
        option domain-name-servers 8.8.8.8, 8.8.4.4;
    }
    interface ${eth_interface};
}
"

chown dhcpd:dhcpd /tmp/tmp_dhcpd.conf
dhcpd -user dhcpd -group dhcpd --no-pid -4 -f -cf /tmp/tmp_dhcpd.conf $eth_interface

exit $?
