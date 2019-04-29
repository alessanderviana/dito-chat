# Dito Chat Pipeline to kubernetes

The technologies used are:
 - Google Cloud,
 - Terraform,
 - Bash script,
 - Docker,
 - Kubernetes,
 - Helm,
 - Jenkins,
 - Canary release strategy


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
We have 2 main branches in this repository: the main and the canary. We also have a Jenkinsfile in the root of repository, in each branch.

In kubernetes, we have 2 deployments spaces in the production namespace: production and canary.

![jenkins-main-canary](pictures/dito-chat-main-canary.png)

In Jenkins, we created a Multi branch pipeline, that look up for changes on the repository each 2 minutes.
Any change (git push) will trigger a pipeline process, conducted by the Jenkinsfile.

When the changes are made in canary branch, the delivery will be made in the canary deployment space of kubernetes. When the changes go to the main branch, the pipeline delivers straight to production deployment space of kubernetes.

![canary-release-strategy](pictures/canary-release-strategy.png)

The canary / production deployment strategy is more used when the tests process isn't much well defined. The production release is delivered first in the canary deployment space that receives a percetual of the real app access traffic (for a subset of users). After verify that app is 100% functional and no problems, the delivery is made in the real production deployment space.
