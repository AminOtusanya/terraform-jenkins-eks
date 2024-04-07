data "aws_availability_zones" "azs" {

}


data "aws_iam_user" "existing_user" {
  user_name = var.aws_iam_user
}

data "aws_iam_policy" "AmazonEKSAdminPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}