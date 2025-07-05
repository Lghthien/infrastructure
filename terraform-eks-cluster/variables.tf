variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for subnets"
  default     = "10.1.0.0/24"
}

variable "node_instance_type" {
  description = "The EC2 instance type for worker nodes"
  default     = "t3.medium"
}

variable "desired_size" {
  description = "The desired size for the node group"
  default     = 3
}

variable "max_size" {
  description = "The max size for the node group"
  default     = 3
}

variable "min_size" {
  description = "The min size for the node group"
  default     = 3
}

variable "node_role_arn" {
  description = "The ARN of the IAM role for worker nodes"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "travelweb-eks-cluster"
  type        = string
}
