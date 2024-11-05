```markdown
# detemine your Host os you will use, we will be using ubuntu server

1. download the ubuntu server ISO from: 
https://ubuntu.com/download/server/thank-you?version=24.04.1&architecture=amd64&lts=true
2. make a bootable usb using a tool like belena etcher or your preferred method. 
3. plug that USB into a working pc and install ubuntu server.
4. for our control node we went with the below parameters

Naming convention: 
k8s-control-xx with xx being the school computer number for the pc
password: (super secret password wink wink)
our static ip will be 10.0.0.xx/16 with xx also matching the the computer number

## Kubernetes Cluster Setup Guide
## Step 1: Update and Upgrade

Update your system packages to ensure everything is up-to-date.

```bash
sudo apt update
sudo apt upgrade -y
reboot
```

---

## Step 2: Install Docker

Docker is required to run containers on your PC.

```bash
sudo apt install docker.io
```

After installation, log out and back in to apply the Docker group change.

---

## Step 3: Install Kubernetes Tools (kubeadm, kubelet, and kubectl)

These tools will allow you to set up and manage your Kubernetes cluster.

```bash
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet

```

---

## Step 4: Initialize the Kubernetes Control Plane

Run the following command on the first PC to set up the control plane node.

```bash
##disable swap


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
