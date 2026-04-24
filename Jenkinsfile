pipeline {
agent any

stages {
    stage('Terraform Init') {
        steps {
            dir('terraform-aws') {
                sh 'terraform init'
            }
        }
    }

    stage('Terraform Apply') {
        steps {
            dir('terraform-aws') {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

}
