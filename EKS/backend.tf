terraform {
  backend "s3" {
    profile = "jenkins-eks-tf"
    bucket = "my-project-backend"
    key    = "eks/terraform.tfstate"
    region = "us-west-1"
  }
}