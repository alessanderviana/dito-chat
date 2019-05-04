#!/usr/bin/env bash

# Create the production namespace
kubectl create ns production

# Create the redis pod
kubectl --namespace=production create -f kubernetes/redis/redis.yaml

# Create a Metal LoadBalancer
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml

# Create the metallb ConfigMap
NODE_NET=$( kubectl get nodes -owide | grep node-1 | awk '{ print $6 }' | awk -F'.' '{print $1"."$2"."$3"."}' )
cat > /tmp/metallb-cmap.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - ${NODE_NET}240-${NODE_NET}250
EOF
kubectl apply -f /tmp/metallb-cmap.yaml

# Create the frontend and backend services deployments
kubectl --namespace=production apply -f kubernetes/services

# Get the cluster IPs
export REDIS_C_IP=$( kubectl get svc -n production | grep redis | awk '{ print $3 }' )
export BACK_C_IP=$( kubectl get svc -n production | grep backend | awk '{ print $3 }' )
export FRONT_C_IP=$( kubectl get svc -n production | grep frontend | awk '{ print $3 }' )

# Create the canary deployment
envsubst < kubernetes/canary/backend-canary-template.yml > kubernetes/canary/backend-canary.yaml
kubectl --namespace=production create -f kubernetes/canary/backend-canary.yaml
envsubst < kubernetes/canary/frontend-canary-template.yml > kubernetes/canary/frontend-canary.yaml
kubectl --namespace=production create -f kubernetes/canary/frontend-canary.yaml

# Create the production deployments
envsubst < kubernetes/production/backend-production-template.yml > kubernetes/production/backend-production.yaml
kubectl --namespace=production apply -f kubernetes/production/backend-production.yaml
envsubst < kubernetes/production/frontend-production-template.yml > kubernetes/production/frontend-production.yaml
kubectl --namespace=production apply -f kubernetes/production/frontend-production.yaml

# Scale the production deployment
kubectl --namespace=production scale deployment chat-frontend-production --replicas=4

# Test
# while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1;  done
