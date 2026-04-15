pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ragav5/devops-demo .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push ragav5/devops-demo'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([string(credentialsId: 'k8s-token', variable: 'K8S_TOKEN')]) {
                    sh '''
                    kubectl config set-cluster k8s-cluster --server=https://host.docker.internal:60631 --insecure-skip-tls-verify=true
                    kubectl config set-credentials jenkins --token=$K8S_TOKEN
                    kubectl config set-context jenkins-context --cluster=k8s-cluster --user=jenkins
                    kubectl config use-context jenkins-context

                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
                sh 'kubectl get svc'
            }
        }
    }
}