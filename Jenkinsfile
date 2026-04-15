pipeline {
    agent any

    environment {
        IMAGE_NAME = "ragav5/devops-demo"
        KUBE_SERVER = "https://host.docker.internal:60631"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker push $IMAGE_NAME
                    '''
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
- name: kubernetes
  cluster:
    server: $KUBE_SERVER
    insecure-skip-tls-verify: true
contexts:
- name: jenkins-context
  context:
    cluster: kubernetes
    user: jenkins
current-context: jenkins-context
users:
- name: jenkins
  user:
    token: $K8S_TOKEN
EOF

                    export KUBECONFIG=$HOME/.kube/config

                    echo "Checking cluster access..."
                    kubectl get nodes

                    echo "Deploying to Kubernetes..."
                    kubectl apply -f deployment.yaml --validate=false
                    kubectl apply -f service.yaml --validate=false
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                kubectl get pods
                kubectl get svc
                '''
            }
        }
    }
}