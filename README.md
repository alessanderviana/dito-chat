# Dito Chat Pipeline to kubernetes

As tecnologias utilizadas são:
 - Google Cloud,
 - Terraform,
 - Bash script,
 - Docker,
 - Kubernetes,
 - Jenkins,
 - Helm

Terraform e Bash
----------------
O Terraform + o Bash script foram utilizados para provisionar as instâncias na nuvem do Google. Estas instâncias, quando terminam o startup, já estão prontas para o uso, com Docker e Kubernetes instalados.
Dentro destas instâncias, temos que executar mais alguns scripts para: A) configuração inicial do cluster, B) instalação do Helm, C) criação do pod do Jenkins (utilizando o Helm) e D) configuração dos ambientes da aplicação (namespace e os deployments production e canary).

Docker
------
O Docker, que dispensa comentários, foi utilizado para "conteinerizar" as aplicações (frontend, backend e redis).

Kubernetes
----------
O kubernetes é disparado o melhor orquestrador de conteiners da atualidade, e também tem a vantagem de ser open source.

Just a simple chat app built with React, Go, Websockets and Redis.
