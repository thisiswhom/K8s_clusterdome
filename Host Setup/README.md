sudo apt update
sudo apt upgrade -y
reboot
sudo apt install network-manager -y
sudo nmcli con mod "Wired connection 1"  ipv4.address 10.0.0.5 ipv4.method manual
sudo nmcli con mod "Wired connection 1" ipv4.gateway 10.0.0.1
sudo nmcli con mod "Wired connection 1" ipv4.dns 10.0.0.1
nmcli con down "Wired connection 1"
nmcli con up "Wired connection 1" 
