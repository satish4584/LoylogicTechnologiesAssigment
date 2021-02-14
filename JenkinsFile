pipeline {
    agent any

    stages {
        stage('Clone the repository') {
            steps {
                git branch: 'main', credentialsId: 'GITHUB', url: 'https://github.com/satish4584/docker-jenkinspipeline.git'
            }
        }
        stage('Build/Package Stage') {
           steps{
             sh "./mvnw package"
              }
        }
        stage('Build image and Push'){
		    steps{
            withDockerRegistry(credentialsId: 'DOCKERHUB', url: '') {
                sh "sudo docker build -t springbootappimage:v1.0 ."
                sh "sudo docker tag  springbootappimage:v1.0 stripathiopstree/springbootappimage:v1.0"
                sh "sudo docker image push stripathiopstree/springbootappimage:v1.0"
			  }
            }
          }
          stage('Get Ansible Host and deploy the Application'){
		    steps{
		      sh "cd springbootansible-role"
              sh "cp ec2.ini ec2.py /etc/ansible"
              sh "./ec2.py"
              sh "export ANSIBLE_HOSTS=/etc/ansible/ec2.py && export EC2_INI_PATH=/etc/ansible/ec2.ini"
              sh "ansible-playbook deployspringboot.yml –extra-vars  'variable_host=us-east-1b'"
              sh "ansible-playbook deployspringboot.yml"
			}

		 }
	}

}
