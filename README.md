# Kubernetes Cluster for Folding@Home on Raspberry Pi Control Nodes and Windows Worker Nodes

## Project Overview
This project sets up a Kubernetes cluster designed to distribute **Folding@Home** workloads. The cluster is composed of:
- **3 Raspberry Pis** serving as control nodes (master nodes).
- **1 or more machines with blank hard drives** serving as worker nodes.

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
  - 3 Raspberry Pi devices (Raspberry Pi 4 recommended) 
  - 1 or more machines with blank hard drives
- **Software:**
  - **K8s** installed on Raspberry Pis (for lightweight Kubernetes distribution).
  - **kubectl** installed on the control node and Windows machines for management and debugging.
  - Folding@Home Docker container image (`foldingathome/fahclient`).

## Architecture
- **Control Nodes**: The Raspberry Pis handle the Kubernetes control plane tasks, managing the cluster's state, scheduling, and configuration.
- **Worker Nodes**: The  machines are configured as worker nodes, running the **Folding@Home** containers and executing distributed computing tasks.

![Architecture Diagram](assets/architecture.png) <!-- Placeholder for an architecture diagram -->

## Setup Instructions

### 1. Prepare the Control Nodes (Raspberry Pis)
**Follow Control Node Setup**:

### 2. Prepare the Worker Nodes 
**Follow Worker Node Setup**:

### 3. Deploy Folding@Home Container

## Cluster Management
- **Monitoring**: Use `kubectl get nodes` and `kubectl get pods` to monitor node and pod health.
- **Scaling**: Adjust the number of replicas in the `fah-deployment.yaml` file to scale workloads.
- **Logging**: Access logs using `kubectl logs <pod-name>` to troubleshoot or monitor Folding@Home tasks.

## Running Folding@Home
This configuration sets up the cluster to run Folding@Home workloads continuously. Ensure the worker nodes remain connected to the network and Docker Desktop remains active on each Windows machine.

---

## Contributors
- Kevin Carter
- [Hunter O'Rourke]((https://github.com/orourkeh))
- [Contributor 2](https://github.com/contributor2)

Please reach out with questions or suggestions for improvement. Contributions are welcome!
