node {
    def app

    stage('Build frontend') {
        sh 'ls -l && pwd'
        app = docker.build('ale55ander/frontend')

    }
    stage('Test frontend') {
        app.withRun('-p 3000:3000') {
            sh 'npm test /frontend'
        }
    }
}
