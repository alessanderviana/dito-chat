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
        stage('Define Registry') {
            steps {
                node('master') {
                    script {
                        hub = docker.withRegistry("", "docker-hub-credentials")
                    }
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
                            stage('Push Docker') {
                                backend.push 'latest'
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
                            stage('Push Docker') {
                                frontend.push 'latest'
                            }
                        }
                    }
                }
            }
        }
    }
}
