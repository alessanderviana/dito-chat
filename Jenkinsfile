#!/usr/bin/env groovy

pipeline {

    agent none

    stages {
        stage('Git Checkout') {
            agent any
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
        stage('Frontend test') {
            node {
                echo 'Testing frontend ...'
                sh '''
                pwd
                ls -l
                '''
                docker.image('ale55ander/frontend:latest').withRun('-p 3000:3000') {
                    sh 'npm run /frontend'
                }
            }
        }
    }
}
