pipeline {
    agent none
    stages {
        stage('Docker:Go') {
            steps {
                node {
                    def backend = docker.build('ale55ander/backend', 'backend')
                    script {
                        stage('Get packages') {
                            backend.inside {
                                sh 'cd backend && go get ./...'
                            }
                        }
                        stage('Test App') {
                            backend.inside {
                                sh 'cd backend && go test ./...'
                            }
                        }
                        stage('Build App') {
                            backend.inside {
                                sh 'cd backend && go build'
                            }
                        }
                        stage('Push Docker') {
                            backend.push 'latest'
                        }
                    }
                }
            }
        }
        stage('Docker:Node') {
            node {
                def frontend = docker.build('ale55ander/frontend', 'frontend')
                steps {
                    script {
                        stage('Install packages') {
                            frontend.inside {
                                sh 'cd frontend && npm install'
                            }
                        }
                        stage('Run backend') {
                            backend.withRun('-p 8080:8080') {
                                    sh 'echo 1'
                            }
                        }
                        stage('Test App') {
                            frontend.inside {
                                sh 'cd frontend && npm run test'
                            }
                        }
                        stage('Cleaning') {
                            frontend.inside {
                                sh 'cd frontend && npm prune --production'
                            }
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
