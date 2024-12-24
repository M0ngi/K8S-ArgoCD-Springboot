pipeline {
    agent any
    
    environment {
        DOCKERHUB = credentials('dockerhub_m0ngi')
        SNYK_TOKEN = credentials('snyk')
        IMAGE_NAME = 'm0ngi/mini-projet-springboot'
    }
    
    stages {
        stage('Pull image from Dockerhub') {
            steps {
                sh 'docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW'
                sh "docker pull ${IMAGE_NAME}:${DOCKERTAG}"
            }
        }

        stage('Run Snyk Container Test') {
            steps {
                sh 'docker run --rm -e SNYK_TOKEN=$SNYK_TOKEN -v /var/run/docker.sock:/var/run/docker.sock snyk/snyk:docker snyk test --docker $IMAGE_NAME:$DOCKERTAG'
            }
        }

        stage('Clean up') {
            steps {
                sh "docker rmi ${IMAGE_NAME}:${DOCKERTAG}"
                sh 'docker logout' 
            }
        }
    }
}