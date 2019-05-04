pipeline {

    agent none

    stages {

        stage('BackEnd') {
            agent {
                docker {
                    image 'golang:1.11'
                    args '-p 8080:8080'
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

        stage('FrontEnd') {
            agent {
                docker {
                    image 'node:8.7.0-alpine'
                    args '-p 3000:3000'
                    reuseNode true
                }
            }
            steps {
                script {
                    stage('Install') {
                        sh 'cd frontend && npm install'
                    }
                    stage('Test') {
                        sh 'cd frontend && npm test --runInBand'
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
