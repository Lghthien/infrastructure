variable "name" {
  description = "Tên tài nguyên"
  type        = string
}
variable "ami_id" {
  description = "AMI ID cho EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet để đặt EC2"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Danh sách Security Group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "Tên key pair đã tạo sẵn"
  type        = string
}

variable "user_data" {
  type    = string
  default = ""
}
