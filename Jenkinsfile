#!/usr/bin/env groovy

pipeline {

    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checkout code ...'
                checkout scm
            }
        }
        stage('Test') {
            steps {
                echo 'Testing frontend ...'
                cd frontend
                npm test
            }
        }
        stage('Build') {
            steps {
                echo 'Building frontend ...'
                sh 'docker build --tag ale55ander/frontend:latest'
            }
        }
    }
}
