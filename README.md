## What is this repository?
The purpose of this repository is to provide a flexible and organized structure for deploying local virtual machines for development, using Vagrant and libvirt. While designed with Windows VMs in mind, it supports configurations for various VM types, giving developers a consistent folder structure and tooling to easily set up, manage, and scale environments as needed.

This project uses **Vagrant** and **Ansible** to automate the creation and configuration of virtualized environments, including the setup of Active Directory on Windows nodes. It allows for scalable node deployment by adjusting the node count as needed.

## Features
- **Multi-node Vagrant Configurations**: Organize your environment into folders, each containing a `Vagrantfile` to specify VM configurations and node count.
- **Ansible Playbooks for Automation**: Provision and configure nodes with Ansible, automating tasks such as Active Directory setup and other Windows configurations.
- **Active Directory Integration**: Easily deploy a Windows-based Active Directory environment for testing or development purposes.

## Folder Structure
- **Environment Folders**: Each folder contains a `Vagrantfile` with node configurations.
  - `Vagrantfile`: Specifies VM settings (OS, RAM, CPU) and allows for flexible node counts.
- **Ansible Playbooks**: Automate provisioning and configuration tasks on the created nodes.
- **Active Directory Setup**: Preconfigured playbooks or scripts to create and manage AD environments on Windows nodes.


# Install on Linux
---
#### Requirements
- `Vagrant 2.4.1` (https://www.vagrantup.com/downloads)
- `libvirt` as the Vagrant provider (ensure it's installed on your system).
- `A bridged network interface`
- `ansible`

# Project Setup
This repository provides a set of Makefile targets to simplify the setup of your development environment on Fedora and Ubuntu for Vagrant. The targets include:

- **fedora**: Installs Vagrant and required plugins, along with additional dependencies for Fedora.
- **vagrant-plugin**: Installs necessary Vagrant plugins.

Each folder contains its specifics requirements, although the installation of them are usually global scoped once installed.

## Usage

```bash
make all  # Installs Vagrant and plugins on for Fedora
make fedora  # Installs Vagrant and plugins on Fedora
make vagrant-plugin  # Installs Vagrant plugins
```

# Install on Windows (Hyper-V + VM)
May the gods of virtualization have mercy on your soul.

### 1. Enable Hyper-V
To enable Hyper-V on your Windows machine, follow these instructions:  
[Enable Hyper-V on Windows](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v).

### 2. Create a Virtual Switch
To allow virtual machines (VMs) to connect to your local network (LAN) instead of being restricted to NAT-only access, create a **Virtual Switch** in Hyper-V and link it to your network interface card (NIC).

### 3. Create and Install a Fedora VM
1. **Create a VM**: In Hyper-V, create a new **Generation 2** VM for installing Fedora.
2. **Download Fedora**: [Download Fedora Workstation](https://fedoraproject.org/es/workstation/download).
3. **Install Fedora**: Mount the downloaded ISO and install Fedora on the VM.

### 4. Enable Nested Virtualization
Once Fedora is installed and the VM is stopped, enable nested virtualization to allow the VM to host other VMs. Open an elevated PowerShell prompt and run:

```powershell
Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
```

