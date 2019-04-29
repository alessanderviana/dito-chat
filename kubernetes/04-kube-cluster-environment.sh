#!/usr/bin/env bash

# Create the production namespace
kubectl create ns production

# Create the redis pod
kubectl --namespace=production create -f kubernetes/redis/redis.yaml
# kubectl create -f kubernetes/redis

export REDIS_C_IP=$( kubectl get svc -n production | grep redis | awk '{ print $3 }' )
export NODE_IP=$( ifconfig ens4 | grep 'inet addr' | awk -F':' '{ print $2 }' | awk '{ print $1 }' )
export BACK_NODE_PORT=$( kubectl -n production describe svc $( kubectl -n production get svc | grep backend | awk '{ print $1 }' ) | grep 'NodePort:' | awk '{ print $3 }' | awk -F'/' '{ print $1 }' )
export FRONT_C_IP=$( kubectl get svc -n production | grep frontend | awk '{ print $3 }' )

envsubst < kubernetes/production/backend-production.tplt > kubernetes/production/backend-production.yaml
envsubst < kubernetes/production/frontend-production.tplt > kubernetes/production/frontend-production.yaml
envsubst < kubernetes/canary/backend-canary.tplt > kubernetes/canary/backend-canary.yaml
envsubst < kubernetes/canary/frontend-canary.tplt > kubernetes/canary/frontend-canary.yaml

# Create the production deployments
kubectl --namespace=production apply -f kubernetes/production
kubectl --namespace=production apply -f kubernetes/canary
kubectl --namespace=production apply -f kubernetes/services

# Scale the production deployment
kubectl --namespace=production scale deployment chat-frontend-production --replicas=4

# Test
# while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1;  done
