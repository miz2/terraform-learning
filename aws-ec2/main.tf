terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
    
}
resource "aws_instance" "myserver2" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"
    tags = {
      Name="SampleServer"
    }
}