pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
    }
    
    environment {
        DOCKERHUB = credentials('dockerhub_m0ngi')
        IMAGE_NAME = 'm0ngi/mini-projet-springboot'
        MANIFEST_UPDATER_JOB = 'manifest-updater'
        CODE_REPOSITORY = 'https://github.com/M0ngi/K8S-ArgoCD-Springboot-Infra.git'
    }
    
    stages {
        stage('Clone repository') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: "${CODE_REPOSITORY}"]])

            }
        }
        
        stage('Build & Test project') {
            steps {
                sh 'mvn -f ./spring-boot/pom.xml clean package'
            }
        }
        
        stage('Static Code Analysis: Sonarqube') {
            steps {
                sh 'mvn -f ./spring-boot/pom.xml clean package'
            }
        }
        
        stage('Build docker image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ./spring-boot"
            }
        }
        
        stage('Push image to Dockerhub') {
            steps {
                sh 'docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW'
                sh "docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
        
        stage('Trigger ManifestUpdate') {
            steps {
                echo "triggering manifest updater"
                build job: "${MANIFEST_UPDATER_JOB}", parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
            }
        }
        
        stage('Clean up') {
            steps {
                sh "docker rmi ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                sh 'docker logout' 
            }
        }
    }
}