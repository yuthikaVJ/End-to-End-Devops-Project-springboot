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
        stage('Docker Build & Push') {
            steps {
                 withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
                    sh 'printenv'
                    sh 'sudo docker build -t yuthikavj31545/jenkins-demo:""$GIT_COMMIT"" .'
                    sh 'docker push yuthikavj31545/jenkins-demo:""$GIT_COMMIT""'
                }
            }
                
        }
    }
      
}
