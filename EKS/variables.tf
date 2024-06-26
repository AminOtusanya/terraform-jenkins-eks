variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "subnets CIDR"
  type        = list(string)
}

variable "private_subnets" {
  description = "subnets CIDR"
  type        = list(string)
}

variable "aws_iam_user" {
  description = "Role name to attach"
  type        = string
}