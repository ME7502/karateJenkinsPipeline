pipeline {
    agent{
        docker 'maven:latest'
    }
    parameters{
        booleanParam(name: "useTags",defaultValue:false,description:"Toggle this to use tags")
        choice(name: 'TAGS', choices: ['@Parcours', '@Login'], description: 'Pick a tag to use')
    }
    stages {
        stage('launch tests') {
            steps {
                sh "mvn clean compile"
                sh "mvn --version"
                script{
                    params.useTags?sh"mvn test .Dkarate.options='--tags "+ params.TAGS + "'":sh "mvn test"
                }
            }
        }
    }
}