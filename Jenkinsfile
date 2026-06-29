pipeline {
    agent any
    parameters{
        booleanParam(name: "useTags",defaultValue:false,description:"Toggle this to use tags")
        choice(name: 'TAGS', choices: ['@Parcours', '@Login'], description: 'Pick a tag to use')
    }
    stages {
        stage('clean allure results') {
            steps {
                sh '''
                    echo "Suppression du cache Allure..."
                    rm -rf allure-results
                    mkdir -p allure-results
                    echo "Dossier allure-results nettoyé avec succès"
                '''
            }
        }
        stage('launch tests') {
            agent docker {image "maven:4.0.0-rc-5-amazoncorretto-25-debian-trixie"}
            steps {
                sh "mvn clean compile"
                sh "mvn --version"
                if (params.useTags) {
                    sh "mvn test -Dkarate.options='--tags ${params.TAGS}'"
                } else {
                    sh "mvn test"
                }     
                stash name: 'allure-results', includes: 'allure-results/**'
            }
        }
    }
    post {
        success {
            script {
                unstash 'allure-results'
                archiveArtifacts artifacts: 'allure-results/**'
                allure includeProperties: false,
                       jdk: '',
                       results: [[path: 'allure-results']]
            }
        }
    }
}