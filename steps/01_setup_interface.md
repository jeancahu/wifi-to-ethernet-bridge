Set up the ethernet interface up (eth0 for this example) and configure the gateway address
```bash
ip addr show eth0
sudo ip link set eth0 down
sudo ip addr add 10.5.5.1/24 dev enp2s0
sudo ip link set eth0 up
ip addr show eth0
```
