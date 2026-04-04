pipeline {
    agent any

    stages {
        stage('Docker Build') {
            steps {
                sh 'docker build -t ragav5/devops-demo .'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'docker login -u ragav5 -p Raga@apr5'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push ragav5/devops-demo'
            }
        }
    }
}