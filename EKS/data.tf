data "aws_availability_zones" "azs" {

}


data "aws_iam_instance_profile" "existing_role" {
  name = var.role_name

}

data "aws_iam_policy" "AmazonEKSAdminPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}