## What is this repository?
The purpose of this repository is to provide a flexible and organized structure for deploying local virtual machines for development, using Vagrant and libvirt. While designed with Windows VMs in mind, it supports configurations for various VM types, giving developers a consistent folder structure and tooling to easily set up, manage, and scale environments as needed.

This project uses **Vagrant** and **Ansible** to automate the creation and configuration of virtualized environments, including the setup of Active Directory on Windows nodes. It allows for scalable node deployment by adjusting the node count as needed.

# Install on Linux

#### Requirements
- `Vagrant 2.4.1` (https://www.vagrantup.com/downloads)
- `libvirt` as the Vagrant provider (ensure it's installed on your system).
- `A bridged network interface`
- `ansible`

For convenience, you could use the Makefile located in the root folder of the repository itself. (Fedora only)

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

### 5. Start the new Fedora VM.
1. SSH into the VM
2. Follow install on Linux

### Performance Considerations on Windows

When running a Linux VM with nested virtualization enabled, keep in mind that you’re essentially operating two hypervisors (one within the other) to host your VMs. This setup can introduce performance overhead due to the additional virtualization layers. However, there are some adjustments you can make to help reduce this impact:

- **Fixed Disk Size**: Configure Hyper-V to use a fully fixed disk size rather than dynamically expanding storage.
- **Disable Dynamic Memory**: Turn off dynamic memory allocation and allocate a set amount of RAM for the VM to ensure it has the resources it needs without fluctuation.

Applying these settings can help improve performance by reducing the extra load caused by nested virtualization or by Hyper-V way of scaling.

From this point, now you should be using your vagrant box when going through this documentation. Nothing else is meant to be run on the Windows Hyper-V Machine.

## Quick Start

1. **Clone the repository**

2. **Navigate to a Folder**  
   Open a terminal and `cd` into any desired folder in the repository.

3. **Review and Modify Configuration**  
   Open the `Vagrantfile` and adjust settings as needed for your environment.

4. **Start the Virtual Machines**  
   Run `vagrant up` to create and start the VMs.

5. **Optional: Run Ansible**  
   Ansible can be used for additional configuration on your Linux hosts:
   - **Linux Host Configuration**: Run Ansible to update the Linux hosts file with the new VMs.
   - **DNS with Cloudflare**: Optionally, create A records in Cloudflare by passing parameters in Ansible. This requires `CF_TOKEN` and `CF_ZONE` to be defined, along with `-e cloudflare=True` in your command.

## Folder-Specific Details

- **`activedirectory` Folder**  
  Creates a Windows VM with the Active Directory Domain Services (ADDS) role enabled and configured. See the `Vagrantfile` for details.

- **`domain-kontrol-vagrant` Folder**  
  Deploys Windows VMs that automatically join the previously created ADDS domain. Requires a pre-existing Active Directory domain. See the `Vagrantfile` for details.

- **`kontrol-vagrant` Folder**  
  Creates standalone Windows VMs without any domain configuration. See the `Vagrantfile` for details.

## Windows Credentials

- **Username:** `vagrant`
- **Password:** `vagrant`

## Features
- **Multi-node Vagrant Configurations**: Organize your environment into folders, each containing a `Vagrantfile` to specify VM configurations and node count.
- **Ansible Playbooks for Automation**: Provision and configure nodes with Ansible, automating tasks such as Active Directory setup and other Windows configurations.
- **Active Directory Integration**: Easily deploy a Windows-based Active Directory environment for testing or development purposes.

## Folder Structure
- **Environment Folders**: Each folder contains a `Vagrantfile` with node configurations.
  - `Vagrantfile`: Specifies VM settings (OS, RAM, CPU) and allows for flexible node counts.
- **Ansible Playbooks**: Automate provisioning and configuration tasks on the created nodes.
- **Active Directory Setup**: Preconfigured playbooks or scripts to create and manage AD environments on Windows nodes.
