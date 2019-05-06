def hub
def backend
def frontend
pipeline {
    agent none
    stages {
        stage('Git checkout') {
            steps {
                node('master') {
                    checkout scm
                }
            }
        }
        stage('Docker:Go') {
            steps {
                node('master') {
                    script {
                        backend = docker.build('ale55ander/backend', 'backend')
                        backend.inside {
                            stage('Get packages') {
                                sh 'cd backend && go get ./...'
                            }
                            stage('Test App') {
                                sh 'cd backend && go test ./...'
                            }
                            stage('Build App') {
                                sh 'cd backend && go build'
                            }
                        }
                    }
                }
            }
        }
        stage('Docker:Node') {
            steps {
                node('master') {
                    script {
                        sh '''
                            sed -i 's/test": "react-scripts test/test": "CI=true react-scripts test --env=jsdom/' frontend/package.json
                        '''
                        frontend = docker.build('ale55ander/frontend', 'frontend')
                        /* docker.image('ale55ander/backend:latest').withRun('-p 8080:8080') {c ->
                            sh 'echo 1'
                        } */
                        frontend.inside {
                            stage('Install packages') {
                                sh 'cd frontend && npm install'
                            }
                            stage('Test App') {
                                sh 'cd frontend && npm run test'
                            }
                            stage('Cleaning') {
                                sh 'cd frontend && npm prune --production'
                            }
                        }
                    }
                }
            }
        }
        stage('Push Docker') {
            steps {
                node('master') {
                    script {
                        docker.withRegistry("", "docker-hub-credentials") {
                            backend.push 'latest'
                            frontend.push 'latest'
                        }
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            podTemplate(cloud: 'k8sClusterLabel' ,label: 'docker',
            containers: [
                containerTemplate(name: 'kubectl', image: 'amaceog/kubectl', ttyEnabled: true, command: 'cat')
            ]) {
            node('master') {
                stage('Deploy'){
                    container('kubectl') {
                        sh 'kubectl --namespace=production set image deployment/chat-backend-production ale55ander/backend:latest'
                        sh 'kubectl --namespace=production set image deployment/chat-frontend-production ale55ander/frontend:latest'
                    }
                }
            }
          }
        }
    }
}
