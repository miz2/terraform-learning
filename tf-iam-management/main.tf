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
  users_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([
    for user in local.users_data : [
      for role in user.roles : {
        username = user.username
        role     = role
      }
    ]
  ])
}

output "output_users" {
  value = local.users_data[*].username
}

# creating users
resource "aws_iam_user" "users" {
  for_each = { for user in local.users_data : user.username => user }
  name     = each.value.username
  path     = "/"
}
# password creation
resource "aws_iam_user_login_profile" "users" {
  for_each = { for user in local.users_data : user.username => user }
  user     = aws_iam_user.users[each.key].name
  password = each.value.password
  pgp_key  = each.value.pgp_key
}

# attaching policies to users
resource "aws_iam_user_policy" "users" {
  for_each = { for user in local.users_data : user.username => user }
  name     = "${each.value.username}-policy"
  user     = aws_iam_user.users[each.key].name
  policy   = each.value.policy
}