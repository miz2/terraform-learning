terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "myserver2" {
    ami = "ami-0d03cb826412c6b0f"
    instance_type = "t2.micro"
    tags = {
      Name="SampleServer"
    }
}