## Setting up a DHCP server on the eth0 interface

To set up a DHCP server on the eth0 interface in Linux, follow these steps:

1. Install the `isc-dhcp-server` package:

```bash
sudo apt-get update
sudo apt-get install isc-dhcp-server
```


2. Configure the `/etc/dhcp/dhcpd.conf` file to define the DHCP server's configuration. For example:

```bash
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option routers 192.168.1.1;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
```


This example configures a DHCP server to assign IP addresses in the range 192.168.1.100-192.168.1.200 in the subnet 192.168.1.0/24, with a default gateway of 192.168.1.1 and Google DNS servers.

3. Open the `/etc/default/isc-dhcp-server` file and specify the network interface on which the DHCP server will run. For example:

```bash
INTERFACESv4="eth0"
```

4. Restart the DHCP server service:

```bash
sudo systemctl restart isc-dhcp-server
```

With these steps, you should have a DHCP server running on the eth0 interface of your Linux server. Make sure that the devices on the network are configured to obtain an IP address automatically through the DHCP protocol so that they can obtain an IP address from the server.
