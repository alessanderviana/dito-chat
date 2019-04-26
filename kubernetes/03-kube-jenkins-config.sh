#!/usr/bin/env bash

kubectl create -f jenkins/jenkins-deploy.yaml
kubectl create -f jenkins/jenkins-svc.yaml

# Install Jenkins on kubernetes cluster
# helm install -n cd stable/jenkins -f jenkins/jenkins-values.yaml --version 0.16.6 --wait
# helm install --name jenkins stable/jenkins -f jenkins/jenkins-values.yaml --namespace cd-jenkins --version 0.16.6 --wait

# Expose Jenkins port
# export POD_NAME=$(kubectl get pods -l "component=cd-jenkins-master" -o jsonpath="{.items[0].metadata.name}") &&
# kubectl port-forward cd-jenkins-master 8181:8080 >> /dev/null &
# kubectl expose deployment cd-jenkins-master --type=NodePort

# Connect to Jenkins (get password)
# printf $(kubectl get secret cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

#######################################################################################################################
# NOTES:
# 1. Get your 'admin' user password by running:
#   printf $(kubectl get secret --namespace default cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
# 2. Get the Jenkins URL to visit by running these commands in the same shell:
#   export POD_NAME=$(kubectl get pods --namespace default -l "component=cd-jenkins-master" -o jsonpath="{.items[0].metadata.name}")
#   echo http://127.0.0.1:8080
#   kubectl port-forward $POD_NAME 8080:8080
# 3. Login with the password from step 1 and the username: admin
# For more information on running Jenkins on Kubernetes, visit:
# https://cloud.google.com/solutions/jenkins-on-container-engine
# Configure the Kubernetes plugin in Jenkins to use the following Service Account name cd-jenkins using the following steps:
#   Create a Jenkins credential of type Kubernetes service account with service account name cd-jenkins
#   Under configure Jenkins -- Update the credentials config in the cloud section to use the service account credential you created in the step above.
#######################################################################################################################

#  -> to kill: ps aux port | grep port; kill -9 PID
# kubectl get svc
