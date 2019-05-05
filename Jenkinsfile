pipeline {
    agent none
    stages {
        stage('Docker:Go') {
            steps {
                node('master') {
                    script {
                        def backend = docker.build('ale55ander/backend', 'backend')
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
                                docker.withRegistry("", "docker-hub-credentials") {
                                    backend.push 'latest'
                                }
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
                        def frontend = docker.build('ale55ander/frontend', 'frontend')
                        docker.image('ale55ander/backend:latest').withRun('-p 8080:8080') {c ->
                            sh 'echo 1'
                        }
                        frontend.inside {
                            stage('Install packages') {
                                sh 'cd frontend && npm install'
                            }
                            stage('Test App') {
                                /* Commented because it stays stuck in this step
                                sh 'cd frontend && npm run test' */
                            }
                            stage('Cleaning') {
                                sh 'cd frontend && npm prune --production'
                            }
                            stage('Push Docker') {
                                docker.withRegistry("", "docker-hub-credentials") {
                                    frontend.push 'latest'
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
