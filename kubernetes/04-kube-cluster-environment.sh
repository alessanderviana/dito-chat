#!/usr/bin/env bash

# Create the production namespace
kubectl create ns production

# Create the redis pod
kubectl --namespace=production create -f kubernetes/redis/redis.yaml

# Create the production deployments
kubectl --namespace=production apply -f kubernetes/production
kubectl --namespace=production apply -f kubernetes/canary
kubectl --namespace=production apply -f kubernetes/services

# Scale the production deployment
kubectl --namespace=production scale deployment chat-frontend-production --replicas=4

# Test
# while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1;  done
