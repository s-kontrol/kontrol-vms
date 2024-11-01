.PHONY: all fedora vagrant-plugin

all: fedora vagrant-plugin

fedora:
	sudo dnf install vagrant -y
	sudo dnf install virt-install -y
	sudo dnf install libvirt-daemon-config-network libvirt-daemon-kvm qemu-kvm virt-manager virt-viewer -y
	sudo dnf install guestfs-tools python3-libguestfs virt-top -y

vagrant-plugin:
	vagrant plugin install winrm
	vagrant plugin install winrm-fs
	vagrant plugin install winrm-elevated
	vagrant plugin install vagrant-windows-domain
