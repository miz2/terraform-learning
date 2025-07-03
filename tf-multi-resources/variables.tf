variable "ec2_config" {
  type = list(object({
    ami= string
    instance_type=string
  }))
  
}

# key value pair 
# key=value(object{ami,instance})
variable "ec2_map" {
  type = map(object({
    ami= string
    instance_type=string
  }))
  
}