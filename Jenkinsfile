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
          stage('Upload file to Nexus Repository'){
            steps{
               script{
                   def readPomVersion = readMavenPom file: 'pom.xml'
                   def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                   nexusArtifactUploader artifacts: 
                   [
                       [
                           artifactId: 'springboot', 
                           classifier: '', file: 'target/Uber.jar', 
                           type: 'jar'
                        ]
                    ], credentialsId: 'nexus-auth', 
                    groupId: 'com.example', 
                    nexusUrl: 'localhost:8081', 
                    nexusVersion: 'nexus3', protocol: 'http', 
                    repository: nexusRepo, 
                    version: "${readPomVersion.version}"
               }
            }
        }
        stage('Docker image Build'){
            steps{
                script{
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID silapakarn/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID silapakarn/$JOB_NAME:latest'

                }
            }
        }
        
    }
        
}