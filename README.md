# Kubernetes Cluster for Folding@Home on Raspberry Pi Control Nodes and Windows Worker Nodes

## Project Overview
This project sets up a Kubernetes cluster designed to distribute **Folding@Home** workloads. The cluster is composed of:
- **3 Raspberry Pis** serving as control nodes (master nodes).
- **8 Windows machines** serving as worker nodes.

Each node will run containers preconfigured with the **Folding@Home** application, allowing distributed computing tasks to help with protein folding simulations for scientific research.

## Table of Contents
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
- [Cluster Management](#cluster-management)
- [Running Folding@Home](#running-foldinghome)
- [Contributors](#contributors)

---

## Requirements
- **Hardware:**
  - 3 Raspberry Pi devices (Raspberry Pi 4 recommended) with a stable network connection.
  - 8 Windows 10 or Windows 11 desktop/laptop computers.
- **Software:**
  - **K3s** installed on Raspberry Pis (for lightweight Kubernetes distribution).
  - **Docker Desktop** on each Windows machine configured for WSL 2 backend.
  - **kubectl** installed on the control node and Windows machines for management and debugging.
  - Folding@Home Docker container image (`foldingathome/fahclient`).

## Architecture
- **Control Nodes**: The Raspberry Pis handle the Kubernetes control plane tasks, managing the cluster's state, scheduling, and configuration.
- **Worker Nodes**: The Windows machines are configured as worker nodes, running the **Folding@Home** containers and executing distributed computing tasks.

![Architecture Diagram](assets/architecture.png) <!-- Placeholder for an architecture diagram -->

## Setup Instructions

### 1. Prepare the Control Nodes (Raspberry Pis)
1. **Install K3s**:
   - SSH into each Raspberry Pi and run:
     ```bash
     curl -sfL https://get.k3s.io | sh -
     ```
2. **Cluster Initialization**:
   - On the main control node (e.g., `master-1`), retrieve the node token:
     ```bash
     sudo cat /var/lib/rancher/k3s/server/node-token
     ```
   - On each additional Raspberry Pi, join the cluster using this token:
     ```bash
     K3S_URL=https://<master-ip>:6443 K3S_TOKEN=<token> sh -
     ```

### 2. Configure the Worker Nodes (Windows Machines)
1. **Enable WSL 2**:
   - Run in PowerShell:
     ```powershell
     wsl --install
     ```
   - Install a Linux distribution from the Microsoft Store (e.g., Ubuntu).
2. **Install Docker Desktop**:
   - Download and install Docker Desktop, ensuring the WSL 2 backend is enabled.
3. **Connect to the Cluster**:
   - Run the following in the WSL shell to join the cluster:
     ```bash
     K3S_URL=https://<master-ip>:6443 K3S_TOKEN=<token> sh -
     ```
4. **Verify Node Connection**:
   - On any control node, check the nodes’ status to ensure all worker nodes are listed:
     ```bash
     kubectl get nodes
     ```

### 3. Deploy Folding@Home Container
1. **Deploy Folding@Home on Worker Nodes**:
   - Use a Kubernetes Deployment to manage the Folding@Home containers across all worker nodes:
   - Apply this deployment:
     ```bash
     kubectl apply -f fah-deployment.yaml
     ```

## Cluster Management
- **Monitoring**: Use `kubectl get nodes` and `kubectl get pods` to monitor node and pod health.
- **Scaling**: Adjust the number of replicas in the `fah-deployment.yaml` file to scale workloads.
- **Logging**: Access logs using `kubectl logs <pod-name>` to troubleshoot or monitor Folding@Home tasks.

## Running Folding@Home
This configuration sets up the cluster to run Folding@Home workloads continuously. Ensure the worker nodes remain connected to the network and Docker Desktop remains active on each Windows machine.

---

## Contributors
- Kevin Carter
- [Contributor 2](https://github.com/contributor2)

Please reach out with questions or suggestions for improvement. Contributions are welcome!
