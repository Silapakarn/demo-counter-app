pipeline{
    
    agent any 

    tools{
        maven '3.5.0'
    }
    
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
        stage('Integration testing'){
            
            steps{
                
               script{
                    
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven Build'){
            
            steps{
                
               script{
                    
                    sh 'mvn clean install'
                }
            }
        }
        // stage('SonarQube analysis'){
            
        //     steps{
                
        //     //   script{
                    
        //     //         
        //     //     }
        //         echo 'SonarQube'
        //     }
        // }
        // stage('Quality Gate status'){
        //     steps{
        //         echo 'SonarQube'
        //     }
        // }
          stage('Upload war file to nexus'){
            steps{
               script{
                   nexusArtifactUploader artifacts: 
                   [
                       [
                           artifactId: 'springboot', 
                           classifier: '', file: 'target/Uber', 
                           type: 'jar'
                        ]
                    ], credentialsId: 'nexus-auth', 
                    groupId: 'com.example', 
                    nexusUrl: 'localhost:8081', 
                    nexusVersion: 'nexus3', protocol: 'http', 
                    repository: 'demoapp-release', 
                    version: '1.0.0'
               }
            }
        }
        
    }
        
}