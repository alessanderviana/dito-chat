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
                    stage('Install') {
                        sh 'cd frontend && npm install'
                    }
                    stage('Test') {
                        sh 'cd frontend && npm run test'
                    }
                    stage('Prune') {
                        sh 'cd frontend && npm prune --production'
                    }
                }
            }
        }
    }
}
