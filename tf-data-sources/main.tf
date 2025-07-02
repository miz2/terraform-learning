terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

data "aws_region" "regionname" {
  
}
output "regionname" {
  value = data.aws_region.regionname.name
}
# security groups searching 
data "aws_security_group" "sg-1" {
  tags = {
    mywebserver = "http"
  }
}
output "security_group_id" {
  value = data.aws_security_group.sg-1.id
}
# now get the vpc id for some vpc check with tags on aws
data "aws_vpc" "vpc1" {
  tags ={
    ENV="PROD",
    Name="myvpc"
  }
}
output "vpc_id" {
  value = data.aws_vpc.vpc1.id
}

# now which avalaiblity zones
data "aws_availability_zones" "available" {
  state = "available"
}
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

# to get the caller account details
data "aws_caller_identity" "nameofcaller" {
}
output "nameofcaller" {
  value = data.aws_caller_identity.nameofcaller.account_id
}

# can fetch the dynamic data 
# but do not apply as this may result in extra charges :use terrafrom plan and not apply
resource "aws_instance" "myserver2" {
    ami = "${data.aws_ami.name.id}"
    instance_type = "t2.micro"
    tags = {
      Name="SampleServer"
    }
}