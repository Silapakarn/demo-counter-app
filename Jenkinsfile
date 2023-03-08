pipeline {
    agent any
    options { timestamps () }

    stages {
                            
        stage('Build Jar') {
            tools {
                jdk "jdk11"
                maven 'mvn'
            }
            steps {
                script{
                    echo """Build Jar... ${git_url}"""
                    git branch: 'main', url: "${git_url}"
                    if(params.build_jar_flag){
                        sh """
                        java -version
                        mvn verify -DskipUnitTests
                        mvn clean install
                        ls -ltr target
                        """
                    }
                }
            }
        }

        stage('Build Image') {
            steps {
                echo """Build Image... ${image_name}:${image_version}"""
                script{
                    if(params.build_image_flag){
                        sh """
                        mv  ./target/$jar_name .
                        docker build -t ${image_name}:${image_version} .
                        docker image ls ${image_name}
                        """
                    }
                }
            }
        }
        
        stage('Push Image Into AWS ECR') {
                    
            steps {
                script{
                    echo """Push Image Into AWS ECR... ${image_name}:${image_version}"""
                    sh 'aws --version'
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-jenkins-demo',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // some block
                        sh """
                            docker image ls ${image_name}
                            docker tag ${image_name}:${image_version} 096090030316.dkr.ecr.ap-southeast-1.amazonaws.com/bmp_ui:${image_version}    
                            aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 096090030316.dkr.ecr.ap-southeast-1.amazonaws.com
                            docker push 096090030316.dkr.ecr.ap-southeast-1.amazonaws.com/bmp_ui:${image_version}
                                
                        """                         
                    }
                }
            }
        }
        
        
    }

    post {
        always {
            echo "You can always see this"
            sh """
                docker image ls ${image_name}
                docker rmi ${image_name}:${image_version}
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