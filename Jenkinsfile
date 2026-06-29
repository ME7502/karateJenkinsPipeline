pipeline {
    agent{
        docker 'maven:latest'
    }
    stages {
        stage('launch tests') {
            steps {
                sh "mvn test"
            }
        }
    }
}