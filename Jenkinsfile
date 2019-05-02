pipeline {

    agent none
    tools {nodejs "node"}

    stages {
        stage('Node dependencies') {
            agent any
            steps {
                echo 'Installing ...'
                sh 'pwd ; ls -l'
                sh 'npm install'
            }
        }
        stage('Test') {
            agent any
            steps {
                echo 'Testing frontend ...'
                sh 'cd frontend'
                sh 'npm test'
            }
        }
    }
}
