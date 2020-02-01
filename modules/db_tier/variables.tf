variable "vpc_id" {
  description = "vpc id of which the app is inside"
}

variable "gateway_id" {
  description = "gateway id of the app"
}

variable "name" {
  description = "replaces the names in the code"
}

variable "ami" {
  description = "replces the ami in the code"
}

variable "app_security_group_id" {
  description = "security group from app"
}
