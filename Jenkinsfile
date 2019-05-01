node {
    def app

    stage('Build frontend') {
        sh 'pwd && ls -l'
        app = docker.build()

    }
    stage('Test frontend') {
        app.withRun('-p 3000:3000') {
            sh 'npm test /frontend'
        }
    }
}
