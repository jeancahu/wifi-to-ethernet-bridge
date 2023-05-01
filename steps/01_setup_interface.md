ip addr show eth0
sudo ip link set eth0 down

sudo ip addr add 192.168.1.1/24 dev enp2s0

sudo ip link set eth0 up
ip addr show eth0
