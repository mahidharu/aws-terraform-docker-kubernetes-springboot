pipeline {
  agent any

  tools {
    maven 'Maven'
    jdk 'JDK8'
  }

  parameters {
    string(name: 'environment', defaultValue: 'dev', description: 'Workspace/environment file to use for deployment')
  }

  environment {
    AWS_REGION  = "us-east-1"
    AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    AWS_ACCOUNT_ID = credentials('aws_account_id')
    TF_IN_AUTOMATION  = '1'
    REPO_NAME  = "demo-repo"
  }

  stages {

    stage ('Initialize') {
        steps {
            sh '''
                echo "PATH = ${PATH}"
                echo "M2_HOME = ${M2_HOME}"
            ''' 
        }
    }

    stage ('Build') {
        steps {
            // Run the maven build
            sh "mvn clean verify"
        }
    }


    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }

    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false -var-file=./params/${params.environment}/variables.tfvars"
        //sh "terraform plan -out=tfplan -input=false"
      }
    }

    stage('Terraform Apply') {
      steps {
        //input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }

    //stage('Terraform Destroy') {
    //  steps {
        //input 'Apply Plan'
    //    sh "terraform destroy -auto-approve=true"
    //  }
    //}

    stage ('Package') {
        steps {
            echo 'Docker Build.'
            sh 'docker build -t rest-service:latest .'
            echo 'Docker Images.'
            sh 'docker images'
            script {
              IMAGE_ID = sh (
                  script: 'docker images --filter="reference=rest-service" --quiet',
                  returnStatus: true
              ) == 0
            }
            echo 'Docker Tag.'
            sh 'docker tag ${IMAGE_ID} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:latest'
            echo 'Docker Push.'
            sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}'
            echo 'Docker Images.'
            sh 'docker images'
        }
    }

  }
}