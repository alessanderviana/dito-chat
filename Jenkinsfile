pipeline {

    agent none

    stages {

        stage('BackEnd') {
            agent {
                // It's built from a custom `Dockerfile` in the directory `backend/`
                dockerfile {
                    dir 'backend'
                    // Use the same node as the rest of the build
                    reuseNode true
                }
            }
            steps {
                script {
                    // You could split this up into multiple stages if you wanted to
                    stage('Test') {
                        sh 'cd backend && go get -t ./...'
                        sh 'cd backend && go test .'
                    }
                    stage('Build') {
                        sh 'cd backend && go build .'
                    }
                }
            }
            }
        }

        stage('FrontEnd') {
            agent {
                // It is built from a custom `Dockerfile` in the directory `frontend/`
                dockerfile {
                    dir 'frontend'
                    // Use the same node as the rest of the build
                    reuseNode true
                }
            }
            steps {
                script {
                    stage('Install') {
                        sh 'cd frontend && npm install'
                    }
                    stage('Test') {
                        sh 'cd frontend && npm test --forceExit'
                    }
                }
            }
        }

        /* stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        } */

    }

}
