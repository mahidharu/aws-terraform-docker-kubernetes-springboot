pipeline {
  agent any

  parameters {
    string(name: 'environment', defaultValue: 'dev', description: 'Workspace/environment file to use for deployment')
  }

  stages {

    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }

    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false"
      }
    }

    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }
  }
}