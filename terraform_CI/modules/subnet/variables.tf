variable "name" { type = string }
variable "vpc_id" { type = string }
variable "cidr_block" { type = string }
variable "az" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
