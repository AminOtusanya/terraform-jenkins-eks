terraform {
  backend "s3" {
    bucket = "my-project-backend"
    key    = "eks/terraform.tfstate"
    region = "us-west-1"
  }
}