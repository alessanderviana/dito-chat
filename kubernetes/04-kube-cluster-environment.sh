#!/usr/bin/env bash

# Create the production namespace
kubectl create ns production

# Create the redis pod
kubectl --namespace=production create -f kubernetes/redis/redis.yaml

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
kubectl --namespace=production apply -f kubernetes/production
# kubectl --namespace=production apply -f kubernetes/canary

# Scale the production deployment
kubectl --namespace=production scale deployment chat-frontend-production --replicas=4

# Test
# while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1;  done
