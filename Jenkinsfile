pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS-creds')
        AWS_SECRET_ACCESS_KEY = credentials('AWS-creds')
        DOCKERHUB_CREDENTIALS = credentials('Dockerhub-creds')
    }
    stages {
        stage('checkout') {
            steps {
                git (
                    url: 'https://github.com/vedashreeath/Devops-projects',
                    branch: 'master'
                )
            }
        }
        stage('login') {
            steps {
                sh 'docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}'
            }
        }
        stage('build') {
            steps {
                dir('Project-1') {
                    script {
                        def imageName = "veda12/webimage:latest"
                        sh "DOCKER_BUILDKIT=0 docker build -t ${imageName} ."
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
    }
}
