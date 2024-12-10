pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials("docker-hub") // Corrected credentials ID
       }
    stages {
        stage('Clone Code') {
            steps {
                echo "scm checkout"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "docker-hub") {
                        sh '''
                        # Provide the execute permission to the build script
                        chmod +x build.sh
                            
                        # Call the build.sh script with the image name
                        ./build.sh
                        '''
                    }
                }
            }
        }
          stage('deploy Docker Image') {
            steps {
                script {
                     docker.withRegistry('https://index.docker.io/v1/', "docker-hub") {
                        sh '''
                        # Provide the execute permission to the build script
                        chmod +x deploy.sh
                            
                        # Call the build.sh script with the image name
                        ./deploy.sh
                        '''
                     }
                }
            }
        }
    }
}
