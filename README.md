# wifi-to-ethernet-bridge

This Bash script sets up a DHCP server on a Linux machine to share its internet connection with devices connected to an ethernet interface. It first checks if the necessary dependencies, `dhcpd` and `fzf`, are installed, and if not, it provides instructions on how to install them via apt or pacman.

It then prompts the user to select the ethernet and wireless interfaces to use. The script sets up the selected ethernet interface by assigning it an IP address, bringing it down and back up, and checking that it is up. It then configures the machine to forward internet traffic to the selected wireless interface using sysctl and sets up the necessary iptables rules.

Finally, the script generates a temporary configuration file for dhcpd and starts the DHCP service in foreground mode.
