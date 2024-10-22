pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('Barbie$44')  // Jenkins credentials for Docker Hub
        AWS_ACCESS_KEY_ID = credentials('AKIAQWHCQFU5KQB7X7C2')  // Replace with your actual credential ID
        AWS_SECRET_ACCESS_KEY = credentials('ngN19aicCZVNqBeDZOndJZZUIv58OlRKQTV6u/QV')  // Replace with your actual credential ID
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/vedashreeath/Devops-projects.git'  // Your GitHub repo URL
            }
        }
      stage('Configure AWS CLI') {
            steps {
                script {
                    // Configure AWS CLI with the credentials
                    sh '''
                    aws configure set aws_access_key_id $AWS_CREDENTIALS_USR
                    aws configure set aws_secret_access_key $AWS_CREDENTIALS_PSW
                    aws configure set default.region your-region  # Replace with your AWS region
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
