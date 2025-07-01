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

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="my_vpc"
    }
}

# private subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1./24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "private-subnet"
  }
}
# public subnet

resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.1./24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public-subnet"
  }
}

# internet gateway 
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}
# route table 
resource "aws_route_table" "my-rt" {
vpc_id =aws_vpc.my_vpc.id
route{
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
} 
}

resource "aws_route_table_association" "public-sub" {
#   associate the route table with subnet
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public-subnet.id
}

# creating an ec2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "MyEC2Instance"
  }
}