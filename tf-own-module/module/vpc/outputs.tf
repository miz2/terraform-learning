output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  public_subnet_output = {
    for key, config in local.public_subnet : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    }
  }
  private_subnet_output = {
    for key, config in var.subnet_config : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    } if !config.public
  }
}

output "public_subnets" {
  value = local.public_subnet_output
}

output "private_subnets" {
  value = local.private_subnet_output
}
