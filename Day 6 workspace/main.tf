provider "aws" {
  region = "ap-south-1"
}

variable "ami" {
  description = "This is AMI"
}

variable "instance_type" {
  description = "Instance type"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "prod" = "t2.medum"
    "stage" = "t2.large"
  }
}

module "ec2_instance" {
  source = "./module"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}