terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
  backend "s3" {
    bucket         = "demo-bucket-bde47062ac8f5d9e"
    key            = "backend.tfstate"
    region         = "ap-south-1"
  }
}

provider "aws" {
    region = "ap-south-1"
}
resource "aws_instance" "myserver2" {
    ami = "ami-0d03cb826412c6b0f"
    instance_type = "t2.micro"
    tags = {
      Name="SampleServer"
    }
}