variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_group_name" {
  description = "Node group name"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the node group"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired size for the node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max size for the node group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Min size for the node group"
  type        = number
  default     = 1
}

variable "taint_key" {
  description = "Key for the taint"
  type        = string
}

variable "taint_value" {
  description = "Value for the taint"
  type        = string
}

variable "taint_effect" {
  description = "Effect for the taint"
  type        = string
}

variable "instance_types" {
  description = "Instance types for the node group"
  type        = list(string)
  default     = ["t3.small"]
}
