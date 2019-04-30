pipeline {

    agent any

    stages{
        stage('Git Checkout') {
            steps {
                echo 'Checkout code ...'
                checkout scm
            }
        }
        stage('Build frontend') {
            steps {
                echo 'Building frontend ...'
                agent {
                    dockerfile {
                        dir 'frontend'
                        additionalBuildArgs  '--tag ale55ander/frontend:latest'
                    }
                }
            }
        }
        /* stage('Frontend test') {
            steps {
                echo 'Testing frontend ...'
                sh '''
                pwd
                ls -l
                '''
                node('master') {
                    docker.image('ale55ander/frontend:latest').withRun('-p 3000:3000') {
                        sh 'npm run /frontend'
                    }
                }
            }
        } */
    }
}
