pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('docker-hub-cred')
        IMAGE_NAME = 'theatomicxm/college-notice-board:latest'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/theatomicxm/college-notice-board.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.IMAGE_NAME}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-cred') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig(credentialsId: 'kubeconfig-cred', serverUrl: '') {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
