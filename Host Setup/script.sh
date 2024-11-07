#!/bin/bash

step_explain() {
  echo -e "\n[ ]performing, $1 \n"
  bash -c "$1"
  echo -e "\n[+]completed, $1 \n"
}


step_explain "apt update"
step_explain "apt upgrade -y"
step_explain "apt install -y docker.io"
step_explain "mkdir -p -m 755 /etc/apt/keyrings"
step_explain "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg"
step_explain "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list"
step_explain "apt-get update"
step_explain "apt-get install -y kubelet kubeadm kubectl"
step_explain "apt-mark hold kubelet kubeadm kubectl"
step_explain "systemctl enable --now kubelet"
step_explain "apt-get install -y keepalived haproxy"
step_explain "swapoff -a; sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"

echo -e "Setup of Host complete"