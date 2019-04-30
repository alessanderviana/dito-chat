node {

    stage('Build frontend') {
        sh 'ls -l'
        sh 'which docker'
        /* dockerfile {
            dir 'frontend'
            additionalBuildArgs  '--tag ale55ander/frontend:latest'
        } */
    }
    /* stage('Test frontend') {
        docker.image('ale55ander/frontend:latest').withRun('-p 3000:3000') {
            sh 'npm test /frontend'
        }
    } */
}
