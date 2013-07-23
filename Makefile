all:
	packer build template.json

#virtualbox:
#	packer build -only=virtualbox template.json

vmware:
	packer build -only=vmware template.json

add-vmware:
	(vagrant box list | egrep -q 'omnios\s+\(vmware_desktop\)' && \
		vagrant box remove omnios vmware_desktop) || true
	vagrant box add omnios omnios_vmware.box
