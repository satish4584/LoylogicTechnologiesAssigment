LoylogicTechnologiesAssigment

Please follow Below Instructions:
create AWS Infra using Terraform.
    terraform init
    terraform plan
    terraform apply
Jenkins Job will Build the Code and will crate an image and push it to DockerHUb:
Jenkins Server will be up and running on port 8080. using the publicip/DNS Name:8080 do the complete setup of Jenkins server.cerate a Jenkins pipeline Job and run the job. once it will run it will build the Spring boot app. cerate a Application image and upload it to the DockerHub. 
Deployment using Ansible Role:
In the same pipeline job the Jenkins job will deploy the artifat to the Jenkins Slave(we have to connect the Jenkins Slave with ssh passwordless authentication) using Ansible Role.
Ansible will be using dynamic host inventory to get the target machine host ip address.