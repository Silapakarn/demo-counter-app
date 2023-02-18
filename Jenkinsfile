pipeline{
    
    agent any 
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    git branch: 'main', url: 'https://github.com/Silapakarn/demo-counter-app.git'
                }
            }
        }
        stage('UNIT Testing'){
            
            steps{
                
                script{
                    sh 'mvn test'
                }
            }
        }
    }
        
}