resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  taint {
    key    = var.taint_key
    value  = var.taint_value
    effect = var.taint_effect
  }

  instance_types = var.instance_types
}

output "node_group_id" {
  value = aws_eks_node_group.eks_nodes.id
}
