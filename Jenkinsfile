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
            mkdir -p $HOME/.kube

            cat <<EOF > $HOME/.kube/config
apiVersion: v1
kind: Config
clusters:
- cluster:
    server: https://host.docker.internal:60631
    insecure-skip-tls-verify: true
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: jenkins
  name: jenkins-context
current-context: jenkins-context
users:
- name: jenkins
  user:
    token: $K8S_TOKEN
EOF

            kubectl apply -f deployment.yaml --validate=false
            kubectl apply -f service.yaml --validate=false
            '''
        }
    }
}
    }