terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  project_name = "multi-resources"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = local.project_name
  }
}

resource "aws_subnet" "main" {
  count      = 2
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  
  tags = {
    Name = "${local.project_name}-subnet-${count.index}"
  }
}

# creating 4 ec2 instance
resource "aws_instance" "main" {
  # now for one subnet we need to get ubuntu and other normal ami
  # ami = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region
  # instance_type = "t2.micro"
  ami = var.ec2_config[count.index % length(var.ec2_config)].ami
  instance_type = var.ec2_config[count.index % length(var.ec2_config)].instance_type
  # count = 4

  for_each = var.ec2_map
  # ami = each.value.ami
  # instance_type = each.value.instance_type

# can use for each to make it little better
  count = length(var.ec2_config)
  subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
  # with maps
  # subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))
  tags = {
    Name = "${local.project_name}-instance-${count.index}"
  }
}
output "aws_subnet_ids" {
  value = aws_subnet.main[*].id
}
