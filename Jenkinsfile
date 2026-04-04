pipeline {
    agent any

    stages {
        stage('Docker Build') {
            steps {
                sh 'docker build -t ragav5/devops-demo .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'docker login -u $USER -p $PASS'
                    sh 'docker push ragav5/devops-demo'
                }
            }
        }
    }
}