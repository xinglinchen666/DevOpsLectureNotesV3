# Description
This demos the most common usage of packer - build AMI (Amazon Machine Image)

# Install packer

https://www.packer.io/docs/install

# 1.docker example
This demos a very simple usage of packer - build a docker image.
make sure your docker is installed and then run
```
cd 1.docker-example
packer build build.json
```

# 2.bake-ec2-to-image-shell-provisioner
This demos a basic AMI creation by packer using shell provisioner. 
Please make sure your ssh key and AWS credentials are configured.
```
cd 2.bake-ec2-to-image-shell-provisioner
packer build build.json
```

# 3.bake-ec2-to-image-ansible-provisioner
This demos an AMI creation by packer using ansible provisioner. 
```
cd 2.bake-ec2-to-image-shell-provisioner
packer build build.json
```