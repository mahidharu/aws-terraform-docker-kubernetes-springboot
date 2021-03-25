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
    ECR_ACCESS = credentials('ecr-access')
    REPO_NAME  = "demo-repo"
    REMOTE_ECR = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}"
    SERVICE_NAME = 'rest-service'
    TF_IN_AUTOMATION  = '1'
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

    /*stage ('Build') {
        steps {
            // Run the maven build
            sh "mvn clean verify"
        }
    }*/


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

    /*stage ('Package') {
        steps {
            echo 'Docker Build.'
            sh 'docker build -t rest-servicse:latest .'
            echo 'Local Docker Images.'
            sh 'docker images'
            script {
              IMAGE_ID = sh (
                  script: 'docker images --filter="reference=rest-service" --quiet',
                  returnStatus: true
              ) == 0
            }
            echo 'Docker Tag. From Local to Reote'
            sh "docker tag rest-service:latest ${REMOTE_ECR}:latest"
            echo 'ECR Login .'
            //script {
            //  sh ('$(aws ecr get-login) || error_exit "ECR login failed."')
            //}
            echo 'Docker Push into ECR.'
            sh "docker push ${REMOTE_ECR}:latest"
            echo 'Remote Docker Images.'
            sh 'docker images'
        }
    }*/

    /*stage ('Package') {
        steps {
            echo 'Docker Build.'
            script{
              docker.build("${REPO_NAME}")
            }

            echo 'Docker Tag and Push into Remote ECR.'
            script{
              docker.withRegistry("https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com", "ecr:${AWS_REGION}:ecr-access") {
                docker.image("${REPO_NAME}").push('latest')
              }
            }
        }
    }*/

  }
}