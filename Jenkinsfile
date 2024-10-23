pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('Dockerhub-creds')  // Jenkins credentials for Docker Hub
        AWS_CREDENTIALS = credentials('AWS-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/vedashreeath/Devops-projects.git',
                    branch: 'master'
                    )
            }
  // Your GitHub repo URL
            }
        }
      stage('Configure AWS CLI') {
            steps {
                script {
                    // Configure AWS CLI with the credentials
                    sh '''
                    export AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS_USR}
                    export AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS_PSW}
                    '''
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
