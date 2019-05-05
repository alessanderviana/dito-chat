pipeline {
    agent none
    stages {
        stage('Docker:Go') {
            steps {
                node {
                    def backend = docker.build('ale55ander/backend', 'backend')
                }
            }
            steps {
                backend.inside {
                    sh 'cd backend && go get ./...'
                }
            }
            steps {
                backend.inside {
                    sh 'cd backend && go test ./...'
                }
            }
            steps {
                backend.inside {
                    sh 'cd backend && go build'
                }
            }
            steps {
                backend.push 'latest'
            }
        }
        stage('Docker:Node') {
            node {
                def frontend = docker.build('ale55ander/frontend', 'frontend')
            }
            steps {
                frontend.inside {
                    sh 'cd frontend && npm install'
                }
            }
            steps {
                backend.withRun('-p 8080:8080') {
                        sh 'echo 1'
                }
            }
            steps {
                frontend.inside {
                    sh 'cd frontend && npm run test'
                }
            }
            steps {
                frontend.inside {
                    sh 'cd frontend && npm prune --production'
                }
            }
        }
    }
}
