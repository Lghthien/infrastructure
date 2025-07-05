provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.1.0.0/16"
  subnet_count = 2
}

module "iam" {
  source = "./modules/iam"
}

module "eks-cluster" {
  source           = "./modules/eks-cluster"
  cluster_name     = "travelweb-eks-cluster"
  cluster_role_arn = module.iam.cluster_role_arn
  subnet_ids       = module.vpc.subnet_ids
}

module "eks-node-group-argocd" {
  source          = "./modules/eks-node-group"
  cluster_name    = module.eks-cluster.cluster_name
  node_group_name = "eks-node-group-argocd"
  node_role_arn   = module.iam.node_role_arn
  subnet_ids      = module.vpc.subnet_ids
  desired_size    = 1
  max_size        = 1
  min_size        = 1
  taint_key       = "app"
  taint_value     = "argocd"
  taint_effect    = "NO_SCHEDULE"
  instance_types  = ["t3.small"]
}

module "eks-node-group-prometheus-grafana" {
  source          = "./modules/eks-node-group"
  cluster_name    = module.eks-cluster.cluster_name
  node_group_name = "eks-node-group-prometheus-grafana"
  node_role_arn   = module.iam.node_role_arn
  subnet_ids      = module.vpc.subnet_ids
  desired_size    = 1
  max_size        = 1
  min_size        = 1
  taint_key       = "app"
  taint_value     = "prometheus-grafana"
  taint_effect    = "NO_SCHEDULE"
  instance_types  = ["t3.small"]
}

module "eks-node-group-frontend-backend" {
  source          = "./modules/eks-node-group"
  cluster_name    = module.eks-cluster.cluster_name
  node_group_name = "eks-node-group-frontend-backend"
  node_role_arn   = module.iam.node_role_arn
  subnet_ids      = module.vpc.subnet_ids
  desired_size    = 2
  max_size        = 2
  min_size        = 2
  taint_key       = "app"
  taint_value     = "frontend-backend"
  taint_effect    = "NO_SCHEDULE"
  instance_types  = ["t3.small"]
}

output "cluster_name" {
  value = module.eks-cluster.cluster_name
}

output "cluster_endpoint" {
  value = module.eks-cluster.cluster_endpoint
}
