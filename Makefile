all:
	packer build template.json

#virtualbox:
#	packer build -only=virtualbox template.json

vmware:
	packer build -only=vmware template.json
