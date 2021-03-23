pipeline {
  agent any

  parameters {
    string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
  }

  environment {
    AWS_REGION = "us-east-1"
    AWS_ACCESS_KEY_ID     = credentials('Access Key ID')
    AWS_SECRET_ACCESS_KEY = credentials('Secret Access Key')
    TF_IN_AUTOMATION      = '1'
  }

  stages {

    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }

    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false -var-file=${params.environment}.tfvars"
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