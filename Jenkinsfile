pipeline {
    agent any

    stages {
        stage('Build Artifact - Maven') {
            steps {
                sh 'mvn clean package -DskipTests=true'
                archive 'target/*.jar'
            }
        }
        stage('Unit Tests') {
            steps {
                sh "mvn test"
            }
        }
         stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {

                    sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t yourdockerhubusername/myapp:latest .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push yourdockerhubusername/myapp:latest'
            }
        }
    }
      
}
