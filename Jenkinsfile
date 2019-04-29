#!/usr/bin/env groovy

pipeline {

    agent none
    tools {nodejs "node"}

    stages {
        stage('Checkout') {
            agent any
            steps {
                echo 'Checkout code ...'
                checkout scm
            }
        }
        stage('Test') {
            agent any
            steps {
                echo 'Testing frontend ...'
                sh 'pwd && ls -l'
                sh 'npm install'
                sh 'cd frontend'
                sh 'npm test'
            }
        }
    }
}
