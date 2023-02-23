pipeline { 
    agent any 
    stages {
        stage('Build') { 
            steps { 
                sh "echo 'building..'"
				sh "docker build -t python-image"
            }
        }
        stage('Deploy') {
            steps {
                sh "echo 'Deploying...'"
				sh "docker run -p 4441 -d python-image"
            }
        }
    }
}