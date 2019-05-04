#!/usr/bin/env bash

# Create the wave-net pod
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Bash completion
echo "source <(kubectl completion bash)" >> .bashrc

# Print Master token
echo -e "\n########################################################################################################"
kubeadm token create --print-join-command
echo -e "########################################################################################################\n\n"
