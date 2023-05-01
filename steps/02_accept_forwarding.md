```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
```

Final. Restart the DHCP server service:

```bash
## Ubuntu
sudo systemctl restart isc-dhcp-server

## ArchLinux
sudo systemctl start dhcpd.service
```

With these steps, you should have a DHCP server running on the eth0 interface of your Linux server. Make sure that the devices on the network are configured to obtain an IP address automatically through the DHCP protocol so that they can obtain an IP address from the server.
