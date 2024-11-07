sudo apt install network-manager -y
nmcli con mod eth0 ipv4.address <host IP> ipv4.method manual
nmcli con mod "Wired connection 1" ipv4.gateway <host IP>
sudo nmcli con mod "Wired connection 1" ipv4.dns <DNS Server IP>
nmcli con down "Wired connection 1"
nmcli con up "Wired connection 1" 
