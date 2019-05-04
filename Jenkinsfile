pipeline {
    agent none
    stages {
        stage('Docker:Go') {
            agent {
                docker {
                    image 'golang:1.11'
                    // Use the same node as the rest of the build
                    reuseNode true
                    args '-v $WORKSPACE/backend:/backend'
                }
            }
            steps {
                script {
                    stage('Test app') {
                        sh 'cd backend && go get -t ./...'
                        sh 'cd backend && go test'
                    }
                    stage('Build app') {
                        sh 'cd backend && go build'
                    }
                    stage('Build Docker') {
                        node {
                            sh 'cd backend && docker build -t ale55ander/backend:latest .'
                        }
                    }
                }
            }
        }
        stage('Docker:Node') {
            agent {
                docker {
                    image 'node:8.7.0-alpine'
                    // Use the same node as the rest of the build
                    reuseNode true
                    args '-v $WORKSPACE/frontend:/frontend'
                }
            }
            steps {
                script {
                    stage('Run Docker') {
                        node {
                            sh 'docker run -d -p 8080:8080 ale55ander/backend:latest'
                        }
                    }
                    stage('Install') {
                        sh 'cd frontend && npm install'
                    }
                    stage('Test') {
                        sh 'cd frontend && npm run test'
                    }
                    stage('Prune') {
                        sh 'cd frontend && npm prune --production'
                    }
                    stage('Build Docker') {
                        node {
                            sh 'cd frontend && docker build -t ale55ander/frontend:latest .'
                        }
                    }
                }
            }
        }
    }
}
