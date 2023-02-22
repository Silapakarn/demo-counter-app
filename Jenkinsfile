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
                    sh """
                        id
                        pwd
                        ls -altr
                        """
                    git branch: 'main', url: "${git_url}"
                    
                    // checkout(
                    //         [$class: 'GitSCM', branches: [[name: """refs/tags/${image_version}"""]], 
                    //         doGenerateSubmoduleConfigurations: false, 
                    //         extensions: [
                    //             [$class: 'SubmoduleOption', disableSubmodules: true, 
                    //             parentCredentials: false, recursiveSubmodules: false, reference: '',
                    //             trackingSubmodules: true]
                                
                    //         ], 
                    //         submoduleCfg: [], 
                    //         userRemoteConfigs: [[credentialsId: "git-clone", 
                    //             url: "${git_url}"]]])
                    if(params.build_jar_flag){
                        sh """
                        java -version
                        id
                        pwd
                        ls -ltr
                        
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
                // sh """ rm -rf *"""
                script{
                    if(params.build_image_flag){
            
                        sh """
                        #ip a
                        id
                        pwd
                        mv  ./target/$jar_name .
                        
                        ls -ltr
                        
                        ls
                        
                        docker build -t ${image_name}:${image_version} .
                        docker image ls ${image_name}
                        docker login  -u ${dockerhub_username} -p ${dockerhub_password}
                        docker tag ${image_name}:${image_version} silapakarn/demo_test_build:${image_version}
                        """
                    }
                }
            }
        }
        
        stage('Push Image') {
            steps {
                script{
                 
                        sh """
                            docker image ls ${image_name}
                            docker push silapakarn/demo_test_build:${image_version}
                        """       
                }
            }
        }
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