variable "vpc_config" {
    description = "To get the CIDR and name of VPC from user"
  type = object({
    cidr_block = string
    name        = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block)) && can(cidrhost(var.vpc_config.cidr_block, 1))
    error_message = "Invalid CIDR format ${var.vpc_config.cidr_block}. Please provide a valid CIDR block."
  }
}

variable "subnet_config" {
  description = "Map of subnets with CIDR and AZ"
  type = map(object({
    cidr_block = string
    az         = string
    public=optional(bool, false) # Default to false if not specified
  }))
  validation {
    condition = alltrue([
      for subnet in var.subnet_config : can(cidrnetmask(subnet.cidr_block)) && can(cidrhost(subnet.cidr_block, 1))
    ])
    error_message = "Invalid CIDR format in subnet configuration. Please provide valid CIDR blocks."
  }
}
