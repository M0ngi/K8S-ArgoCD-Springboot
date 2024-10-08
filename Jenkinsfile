pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
    }
    
    environment {
        DOCKERHUB = credentials('dockerhub_m0ngi')
    }
    
    stages {
        stage('Clone repository') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [])

            }
        }
        
        stage('Build project') {
            steps {
                sh 'mvn -f ./spring-boot/pom.xml clean install'
            }
        }
        
        stage('Build docker image') {
            steps {
                sh 'docker build -t m0ngi/mini-projet-springboot ./spring-boot'
            }
        }
        
        stage('Push image to Dockerhub') {
            steps {
                sh 'docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW'
                sh 'docker push m0ngi/mini-projet-springboot'
            }
        }
        
        stage('Clean up') {
            steps {
                sh 'docker rmi m0ngi/mini-projet-springboot'
                sh 'docker logout' 
            }
        }
    }
}