resource "aws_instance" "master" {
   ami  = var.ami
   instance_type = "t2.micro"
   key_name = "JenkinsKey"
   subnet_id = aws_subnet.public-subnet.id
   vpc_security_group_ids = [aws_security_group.sg-master.id]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = file("starter.sh")

  tags {
    Name = "Jenkins-master"
  }
}

resource "aws_instance" "slave" {
   ami  = var.ami
   instance_type = "t2.micro"
   key_name = "JenkinsKey"
   subnet_id = aws_subnet.private-subnet.id
   vpc_security_group_ids = [aws_security_group.sg-slave.id]
   source_dest_check = false
   user_data = file("javaInstall.sh")
  tags {
    Name = "Jenkins-slave"
  }
}