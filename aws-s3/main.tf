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
resource "aws_s3_bucket" "demo-bucket-terraform" {
  bucket = "demo-bucket-1234567890423425"
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.demo-bucket-terraform.bucket
    key    = "myfile.txt"
    source = "./myfile.txt"
}