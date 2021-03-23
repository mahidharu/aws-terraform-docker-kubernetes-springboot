pipeline {
  agent any

  parameters {
    string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
  }

  environment {
    AWS_REGION  = "us-east-1"
    AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    TF_IN_AUTOMATION  = '1'
  }

  stages {

    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }

    sstage('Terraform Plan') {
      steps {
        #sh "terraform plan -out=tfplan -input=false -var-file=./params/${params.environment}/variables.tf"
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