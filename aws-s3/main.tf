terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}
resource "random_id" "rand_id" {
byte_length = 8
}
resource "aws_s3_bucket" "demo-bucket-terraform" {
  bucket = "demo-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.demo-bucket-terraform.bucket
    key    = "myfile.txt"
    source = "./myfile.txt"
}
output "name" {
  value = random_id.rand_id.hex
}