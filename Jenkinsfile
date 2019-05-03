pipeline {

    agent {
        label 'docker'
    }

    stages {

        stage('FrontEnd') {
            agent {
                // It is built from a custom `Dockerfile` in the directory `frontend/`
                dockerfile {
                    dir 'frontend/'
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
                        sh 'cd frontend && npm test'
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
