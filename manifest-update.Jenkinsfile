pipeline {
    agent any
    
    environment {
        DEPLOYMENT_FILE = 'k8s-deployment.yaml'
        COMMIT_EMAIL = 'saidanemongi@gmail.com'
        COMMIT_USERNAME = 'M0ngi'
        IMAGE_NAME = 'm0ngi/mini-projet-springboot'
    }
    
    stages {
        stage('Clone repository') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/M0ngi/K8S-ArgoCD-Springboot-Manifest.git']])
            }
        }
        
        stage('Commit & Push to git') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github_m0ngi', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh "cat ${DEPLOYMENT_FILE}"
                    sh "sed -i 's+${IMAGE_NAME}.*+${IMAGE_NAME}:${DOCKERTAG}+g' ${DEPLOYMENT_FILE}"
                    sh "cat ${DEPLOYMENT_FILE}"
                
                    sh "git config user.email ${COMMIT_EMAIL}"
                    sh "git config user.name ${COMMIT_USERNAME}"
                    sh "git add ."
                    sh "git commit -m 'Updated by job manifest-updater #${env.BUILD_NUMBER}'"
                    sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/M0ngi/K8S-ArgoCD-Springboot-Manifest.git HEAD:main"
                }
            }
        }
    }
}