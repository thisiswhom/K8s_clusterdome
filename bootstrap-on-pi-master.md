```markdown
# Raspberry Pi Kubernetes Cluster Setup Guide

## Step 1: Update and Upgrade

Update your system packages to ensure everything is up-to-date.

```bash
sudo apt update
sudo apt upgrade -y
```

---

## Step 2: Install Docker

Docker is required to run containers on your Pi.

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

After installation, log out and back in to apply the Docker group change.

---

## Step 3: Install Kubernetes Tools (kubeadm, kubelet, and kubectl)

These tools will allow you to set up and manage your Kubernetes cluster.

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

---

## Step 4: Initialize the Kubernetes Control Plane

Run the following command on the first Raspberry Pi to set up the control plane node.

```bash
sudo kubeadm init --control-plane-endpoint="LOAD_BALANCER_IP:6443" --upload-certs --pod-network-cidr=10.244.0.0/16
```

- Replace `LOAD_BALANCER_IP` with your load balancer's IP address.
- This command initializes the first control plane node and configures it for high availability.
- Save the `kubeadm join` command that is output.

On the second and third Pis, run the saved `kubeadm join` command to add them as control plane nodes.

---

## Step 5: Configure kubectl

Configure `kubectl` for the first user to interact with the Kubernetes cluster.

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## Step 6: Install a Pod Network

Kubernetes requires a pod network for inter-pod communication. A popular choice is Calico.

```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

---

## Step 7: Verify Installation

Check that your nodes are up and running.

```bash
kubectl get nodes
```

You should see your Raspberry Pi listed as a node in the `Ready` state.
```