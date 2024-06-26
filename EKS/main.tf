# VPC
# Note: This modeule creates internet gateways and route tables and the associations are created automatically
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true


  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }

}



module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  #EKS Managed Node Group(s)

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
    }
  }

  access_entries = {
    jenkins-eks-terraform = {
      principal_arn    = data.aws_iam_user.existing_user.arn
      kubernetes_group = []
      type             = "STANDARD"

      policy_association = {
        admin = {

          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          type       = "cluster"
          namespace  = []

        }
      }
    }
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

#resource "aws_iam_user_policy_attachment" "eks-admin-policy-attach" {
# user       = data.aws_iam_user.existing_user.user_name
#policy_arn = data.aws_iam_policy.AmazonEKSAdminPolicy.arn
#}

#resource "aws_eks_access_entry" "access_entry" {
# cluster_name  = "my-eks-cluster"
#principal_arn = data.aws_iam_user.existing_user.arn
#type          = "STANDARD"
#}
