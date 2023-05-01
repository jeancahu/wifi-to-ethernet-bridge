## Setting up a DHCP server on the eth0 interface

To set up a DHCP server on the eth0 interface in Linux, follow these steps:

1. Install the `isc-dhcp-server` package for Ubunto/Debian or `dhcp` for Archlinux:

```bash
## Ubuntu/Debian
sudo apt-get update
sudo apt-get install isc-dhcp-server

## ArchLinux
sudo pacman -S dhcp
```


2. Configure the `/etc/dhcp/dhcpd.conf` file (Ubuntu/Debian) or `/etc/dhcpd.conf` file for ArchLinux, to define the DHCP server's configuration. For example:

```bash
shared-network eth0-subnet {
    subnet 192.168.1.0 netmask 255.255.255.0 {
        range 192.168.1.100 192.168.1.200;
        option routers 192.168.1.1;
        option subnet-mask 255.255.255.0;
        option domain-name-servers 8.8.8.8, 8.8.4.4;
    }
    interface eth0;
}
```


This example configures a DHCP server to assign IP addresses in the range 192.168.1.100-192.168.1.200 in the subnet 192.168.1.0/24, with a default gateway of 192.168.1.1 and Google DNS servers.

3. Open the `/etc/default/isc-dhcp-server` (Ubuntu) file and specify the network interface on which the DHCP server will run. For example:

```bash
INTERFACESv4="eth0"
```

For ArchLinux add `interface eth0;` at the end of `/etc/dhcpd.conf` to declare the interface

4. Restart the DHCP server service:

```bash
## Ubuntu
sudo systemctl restart isc-dhcp-server

## ArchLinux
sudo systemctl start dhcpd.service
```

With these steps, you should have a DHCP server running on the eth0 interface of your Linux server. Make sure that the devices on the network are configured to obtain an IP address automatically through the DHCP protocol so that they can obtain an IP address from the server.
