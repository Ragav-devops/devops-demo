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
                sh 'docker build -t devops-demo .'
            }
        }

        stage('Docker Run') {
            steps {
                sh 'docker run -d -p 8081:80 devops-demo'
            }
        }
    }
}