#### global variables used for all ressources
variable "application" {
  default = "demo"
}

variable "environment" {
  default = "d2si"
}

# vpc
variable "cidr_block" {
  default = "192.168.0.0/16"
}

# subnets

variable "netbits" {
  default = "8"
}

variable "public_networks_prefix" {
  default = "0"
}

variable "private_networks_prefix" {
  default = "9"
}

variable "tags" {
  type        = map(string)
  description = "tags"
  default     = {}
}
