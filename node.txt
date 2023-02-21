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
            tools{
                maven '3.9.0'
            }
            
            steps{
                
               script{
                    
                    sh 'mvn test'
                }
            }
        }
        stage('Integration testing'){
            tools{
                maven '3.9.0'
            }
            
            steps{
                
               script{
                    
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven Build'){
            tools{
                maven '3.9.0'
            }
            
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
                //   def readPomVersion = readMavenPom file: 'pom.xml'
                //   def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                //   nexusArtifactUploader artifacts: 
                //   [
                //       [
                //           artifactId: 'springboot', 
                //           classifier: '', file: 'target/Uber.jar', 
                //           type: 'jar'
                //         ]
                //     ], credentialsId: 'nexus-auth', 
                //     groupId: 'com.example', 
                //     nexusUrl: 'localhost:8081', 
                //     nexusVersion: 'nexus3', protocol: 'http', 
                //     repository: nexusRepo, 
                //     version: "${readPomVersion.version}"
                echo 'Upload file to Nexus Repository'
               }
            }
        }
        stage('Docker image Build'){
            steps{
                echo 'Docker image Build'
                script{
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID silapakarn/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID silapakarn/$JOB_NAME:latest'

                }
                
            }
        }
        // stage('Push Docker image'){
        //     steps{
        //         // script{
        //         //         withCredentials([string(credentialsId: 'git_creds', variable: 'docker_hub_cred')]) {
        //         //         sh 'docker login -u silapakarn -p ${docker_hub_cred}'
        //         //         sh 'docker image push silapakarn/$JOB_NAME:v1.$BUILD_ID'
        //         //         sh 'docker image push silapakarn/$JOB_NAME:latest'
        //         //     }
        //         // }
        //         echo 'Push Docker image'
        //     }
        // }
        
    }
    
    post {
        always {
            echo "You can always see this"
            sh """
            ls -ltr target
            """
        }
        success {
            echo "The job ran successfully"
        }
        unstable {
            echo "Gear up! The build is unstable. Try fix it"
        }
        failure {
            echo "OMG! The build failed"
        }
    }
        
}