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

resource "aws_s3_bucket" "demo-web-app-bucket-terraform" {
  bucket = "demo-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "example" {
    bucket = aws_s3_bucket.demo-web-app-bucket-terraform.bucket
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.demo-web-app-bucket-terraform.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.demo-web-app-bucket-terraform.arn}/*"
        }
        ]
    })
}
resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.demo-web-app-bucket-terraform.bucket
    key    = "index.html"
    source = "./index.html"
    content_type = "text/html"
}
resource "aws_s3_object" "styles_css" {
    bucket = aws_s3_bucket.demo-web-app-bucket-terraform.bucket
    key    = "styles.css"
    source = "./styles.css"
    content_type= "text/css"
}
output "name" {
  value = random_id.rand_id.hex
}
resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.demo-web-app-bucket-terraform.id
  index_document {
    suffix = "index.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
# need to add policies then our website will be accesible 
output "namewebsite" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}