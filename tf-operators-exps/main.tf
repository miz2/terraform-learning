terraform {}

#number list
variable "number_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

#list of objects like persons
variable "persons" {
  type = list(object({
    name   = string
    age    = number
    active = bool
  }))
  default = [
    {
      name   = "Alice"
      age    = 30
      active = true
    },
    {
      name   = "Bob"
      age    = 25
      active = false
    }
  ]
}

variable "map_list" {
    type = list(map(number))
    default = [ {
      "one" = 1
      "two" = 2
        "three" = 3
    } ]
  
}

# calculations

locals {
  mul=2*2
  add=2+2
  eq=2!=3
#   double the list
double=[for num in var.number_list : num * 2]

odd=[for num in var.number_list : num if num % 2 != 0]

# get the first name from person list for all
fname=[for person in var.persons : person.name]
mapinfo=[for key,value in var.map_list:key]
# double the values in map

double_map = { for k, v in var.map_list[0] : k => v * 2 }
}
output "output_mul" {
  value = local.mul
}
output "eq" {
  value = local.eq
}
output "double" {
  value = local.double
}

output "odd" {
  value = local.odd
}

output "fname" {
  value = local.fname
}

output "mapinfo" {
  value = local.mapinfo
}
output "double_map" {
  value = local.double_map
}