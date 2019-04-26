#!/usr/bin/env bash

# Install and configure helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz
tar zxfv helm-v2.13.1-linux-amd64.tar.gz && cp linux-amd64/helm linux-amd64/tiller /usr/local/bin
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=ubuntu
# kubectl create clusterrolebinding cluster-admin-role --clusterrole=kube-system:cluster-admin --user=ubuntu
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# kubectl create clusterrolebinding tiller-cluster-role --clusterrole=kube-system:cluster-admin --serviceaccount=tiller
helm init --service-account=tiller && helm repo update
# helm version
