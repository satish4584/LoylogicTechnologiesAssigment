variable "region" {
        default = "us-west-1"
}
variable "aws_access_key" {}

variable "aws_secret_key" {}
variable "ami" {
  default = "ami-047a51fa27710816e"
}
variable "instance_type" {
  default = "r5.large"
}
variable "vpc_cidr" {
	default = "172.20.0.0/16"
}
variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}
variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.20.10.0/24"
}
variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "172.20.20.0.24/24"
}
