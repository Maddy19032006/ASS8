pipeline {
    agent any
    environment {
        IMAGE_NAME = 'theatomicxm/college-notice-board:latest'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${env.IMAGE_NAME} ."
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    bat "echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin"
                    bat "docker push ${env.IMAGE_NAME}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig(credentialsId: 'kubeconfig-cred', serverUrl: '') {
                    bat 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
