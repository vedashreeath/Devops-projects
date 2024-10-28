pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS-creds')
        AWS_SECRET_ACCESS_KEY = credentials('AWS-creds')
        DOCKERHUB_CREDENTIALS = credentials('Dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the entire repository (the Jenkinsfile must remain at the root)
                git(
                    url: 'https://github.com/vedashreeath/Devops-projects',
                    branch: 'master'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                dir('Project-1') {  // Change directory to Project-1 for all build steps
                    script {
                        def imageName = "veda12/webimage:latest"
                        sh "docker build -t ${imageName} ."
                        sh "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
                        sh "docker push ${imageName} -f Dockerfile ."
                    }
                }
            }
        }
    }
}
