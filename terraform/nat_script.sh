#!/bin/bash
set -e

# Update system and install iptables-persistent
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y iptables-persistent

# Enable IP forwarding immediately
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# Enable IP forwarding persistently
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Detect network interfaces (eth0 = public, eth1 = private)
PUB_IFACE="eth0"
PRIV_IFACE="eth1"

# Configure iptables rules for NAT
sudo iptables -t nat -A POSTROUTING -o $PUB_IFACE -j MASQUERADE
sudo iptables -A FORWARD -i $PRIV_IFACE -o $PUB_IFACE -j ACCEPT
sudo iptables -A FORWARD -i $PUB_IFACE -o $PRIV_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT

# Save iptables rules so they persist after reboot
sudo netfilter-persistent save
sudo netfilter-persistent reload
