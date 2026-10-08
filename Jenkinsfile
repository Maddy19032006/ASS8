pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('docker-hub-cred')
        IMAGE_NAME = 'theatomicxm/college-notice-board:latest'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.IMAGE_NAME}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-cred') {
                        // Push the image directly
                        sh "docker push ${env.IMAGE_NAME}"
                    }
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
