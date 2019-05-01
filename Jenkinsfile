node {
    def app

    stage('Build frontend') {
        sh 'ls -l'
        app = docker.build([-f frontend/Dockerfile])

    }
    stage('Test frontend') {
        app.withRun('-p 3000:3000') {
            sh 'npm test /frontend'
        }
    }
}
