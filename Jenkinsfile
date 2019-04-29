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
                sh '''
                pwd && ls -l
                cd frontend
                npm test
                '''
            }
        }
        stage('Build') {
            steps {
                agent {
                    echo 'Building frontend ...'
                    // Equivalent to "docker build -f Dockerfile.build --build-arg version=1.0.2 ./build/
                    dockerfile {
                        dir 'frontend'
                        additionalBuildArgs  '--tag ale55ander/frontend:latest'
                    }
                }
            }
        }
    }
}
