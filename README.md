# Dito Chat Pipeline to kubernetes

The technologies used are:
 - Google Cloud,
 - Terraform,
 - Bash script,
 - Docker,
 - Kubernetes,
 - Helm,
 - Jenkins


Google Cloud
------------
The Google Cloud Platform was the choice for the test environment, because beyond another factors I think it's more simple to use and the instances startup is more faster.

Terraform and Bash
------------------
Terraform + Bash scripts were used to provisione Google Cloud instances. These instances when finish the startup, are already ready to use, with Docker and Kubernetes installed.
Inside these instances we have to run some more scripts to: A) initial cluster configuration, B) Helm installation, C) pod jenkins creation (using Helm) and D) app environment configuration (namespace and the production / canary deployments).

Docker
------
The Docker we've utilized to "containerize" the apps (frontend, backend and redis), is the master in the category.

Kubernetes
----------
The kubernetes is, no doubt, the best container orquestrator nowadays, and also it has an advantage: it is open source.

Helm
----
Helm is a kind of kubernetes package manager and makes easy to install a lot of things inside kubernetes.

Jenkins
-------
Jenkins is the second CI/CD tool most used, it has some disadvantages comparing to first place, as the need of a host to be installed (or container), but its big advantage is, it's open source.

How it works
==============
We have 2 main branches in this repository: main and canary. We also have a Jenkinsfile in the root of repository, in each branch.

In kubernetes, we have 2 deployments spaces in the production namespace: production and canary.

In Jenkins, we have a Multi branch pipeline configured, that look up for changes on the branches each 2 minutes.
Any change (git push) in the repo, will trigger a pipeline process.
