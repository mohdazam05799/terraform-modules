variable "project" {
  type        = string
  description = "Provide Project Name"
}
variable "env" {
  type        = string
  description = "Provide Environment Name Like Dev Staging Prod"
}
variable "vpc_cidr" {
  type = string
}
variable "enable_dns_hostnames" {
  default = true
  type    = bool
}
variable "enable_dns_support" {
  default = true
  type    = bool
}
variable "private_subnet" {
  type    = bool
  default = true
}
variable "public_subnet" {
  type    = bool
  default = true
}
variable "db_subnet" {
  type        = bool
  default     = true
  description = "Mention if DB subnet is required (NAT will not be attached to DB subnets)"
}
variable "public_subnet_count" {
  type = number
}
variable "private_subnet_count" {
  type = number
}
variable "db_subnet_count" {
  type = number
}

variable "nat_count" {
  default = 1
  type    = number

}
