pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'git@github.com:r-sharda/libraryapp.git'
            }
        }
        stage("Docker Build") {
            steps {
                sh 'docker  build -t library:latest .'
            }
        } 
        stage("Docker Tag") {
            steps {
                sh '''
                docker tag library:latest 107531495718.dkr.ecr.us-east-1.amazonaws.com/libraryapp:latest
                tag=`cat version.json | jq -r '.version'`
                docker tag library:latest 107531495718.dkr.ecr.us-east-1.amazonaws.com/libraryapp:"$tag"
                '''
            }
        }
        stage("ECR Login"){
            steps{
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 107531495718.dkr.ecr.us-east-1.amazonaws.com'
            }
        }
        stage("Docker Push"){
            steps{
                sh '''
                docker push 107531495718.dkr.ecr.us-east-1.amazonaws.com/libraryapp:latest
                tag=`cat version.json | jq -r '.version'`
                docker push 107531495718.dkr.ecr.us-east-1.amazonaws.com/libraryapp:"$tag"
                '''
            }
        }  
    }
}
