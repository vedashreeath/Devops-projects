pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('Dockerhub-creds')  // Docker Hub credentials
    AWS_ACCESS_KEY_ID = credentials('('AWS-creds').accessKeyId')
    AWS_SECRET_ACCESS_KEY = credentials('('AWS-creds').secretAccessKey')
}
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/vedashreeath/Devops-projects.git',
                    branch: 'master'
                    )
  // Your GitHub repo URL
            }
        }
      stage('Configure AWS CLI') {
    steps {
        script {
            // AWS CLI configuration can be done here if needed
            sh '''
            aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
            aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
            '''
        }
    }
}
        stage('Login to Docker Hub') {
    steps {
        script {
            sh 'docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}'
        }
    }
}
        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'docker-compose push'
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    // Update the K8s deployment files with the Docker Hub image
                    sh '''
                    kubectl set image deployment/users-service users-service=veda12/users-service:latest
                    kubectl set image deployment/products-service products-service=veda12/products-service:latest
                    kubectl set image deployment/orders-service orders-service=veda12/orders-service:latest
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
