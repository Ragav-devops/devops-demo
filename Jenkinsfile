pipeline {
    agent any

    stages {
        stage('Docker Build') {
            steps {
                sh 'docker build -t ragav5/devops-demo .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'docker login -u $USER -p $PASS'
                    sh 'docker push ragav5/devops-demo'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker pull ragav5/devops-demo'
                sh 'docker run -d -p 8083:80 ragav5/devops-demo'
            }
        }
    }
}