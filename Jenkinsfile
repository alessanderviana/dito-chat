pipeline {

    agent any

    stages{
        stage('Build frontend') {
            steps {
                echo 'Building frontend ...'
                sh '''
                pwd
                ls -l
                '''
                dockerfile {
                    dir 'frontend'
                    additionalBuildArgs  '--tag ale55ander/frontend:latest'
                }
            }
        }
        /* stage('Frontend test') {
            steps {
                echo 'Testing frontend ...'
                node('master') {
                    docker.image('ale55ander/frontend:latest').withRun('-p 3000:3000') {
                        sh 'npm run /frontend'
                    }
                }
            }
        } */
    }
}
