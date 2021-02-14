resource "aws_vpc" "Jenkins-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags {
    Name = "assignment-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.Jenkins-vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-east-1a"

  tags {
    Name = "Jenkins Public Subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Jenkins-vpc.id

  tags {
    Name = "Internet Gateway"
  }
}
resource "aws_route_table" "master-public-rt" {
  vpc_id = aws_vpc.Jenkins-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags {
    Name = "Public Subnet RT"
  }
}

resource "aws_route_table_association" "master-public-rt" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.master-public-rt.id
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.Jenkins-vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "us-east-1b"

  tags {
    Name = "Jenkins Slave Private Subnet"
  }
}
resource "aws_eip" "nat_gateway" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.private-subnet.id
  tags = {
    "Name" = "NatGateway"
  }
}
output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}
resource "aws_route_table" "Slave-private-rt" {
  vpc_id = aws_vpc.Jenkins-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "slave-private-rt" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.Slave-private-rt.id
}

resource "aws_security_group" "sg-master" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  vpc_id =aws_vpc.Jenkins-vpc.id

  tags {
    Name = "Server SG"
  }
}
resource "aws_security_group" "sg-slave"{
  name = "sg_test_web"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  vpc_id = aws_vpc.Jenkins-vpc.id

  tags {
    Name = "SLAVE SG"
  }
}