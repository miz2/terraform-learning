terraform { 
}
# we have built in functions in terraform 
# https://developer.hashicorp.com/terraform/language/functions/built-in
locals {
  value="Hello, World!"
}
variable "string_List" {
    type = list(string)
    default = ["Hello", "Chintu","serv1"]
}
output "output" {
  value = lower(local.value)
}
output "starts" {
  value = startswith(local.value, "Hello")
}
output "ends" {
  value = endswith(local.value, "World!")
}
output "split" {
  value = split(" ", local.value)
}
output "join" {
  value = join("-", var.string_List)
}
output "max" {
  value = max(1, 2, 3, 4, 5)
}
output "min" {
  value = min(1, 2, 3, 4, 5)
}
output "absolute" {
  value = abs(-10)
}
output "length" {
  value = length(var.string_List)
}
output "contains" {
  value = contains(var.string_List, "Hello")
}
output "index" {
  value = index(var.string_List, "serv1")
}
output "toSet" {
    # now no duplicates are allowed
  value = toset(var.string_List)
}
