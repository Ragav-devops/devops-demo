pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo Building application'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ragav5/devops-demo .'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push ragav5/devops-demo'
            }
        }
    }
}