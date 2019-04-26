#!/usr/bin/env bash

# Docker
curl -fsSL https://get.docker.com | sh
usermod -aG docker ubuntu

# Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | tee -a /etc/apt/sources.list
apt-get update -q && apt-get install -y kubelet kubeadm kubectl

# Adjust Docker driver (change to systemd)
cat > /etc/docker/daemon.json <<EOF
{
 "exec-opts": ["native.cgroupdriver=systemd"],
 "log-driver": "json-file",
 "log-opts": {
   "max-size": "100m"
 },
 "storage-driver": "overlay2",
 "storage-opts": [
   "overlay2.override_kernel_check=true"
 ]
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload && systemctl restart docker

# Needed images
kubeadm config images pull | systemd-cat
