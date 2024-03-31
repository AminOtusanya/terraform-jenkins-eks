terraform {
  backend "s3" {
    bucket = "my-project-backend"
    key    = "jenkins/terraform.tfstate"
    region = "us-west-1"
  }
}