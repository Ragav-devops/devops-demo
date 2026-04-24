pipeline {
agent any
stages {
    stage('Checkout') {
        steps {
            git 'https://github.com/Ragav-devops/devops-demo'
        }
    }

    stage('Terraform Init') {
        steps {
            sh 'terraform init'
        }
    }

    stage('Terraform Apply') {
        steps {
            sh 'terraform apply -auto-approve'
        }
    }
}
```

}
