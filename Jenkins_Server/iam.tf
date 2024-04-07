resource "aws_iam_role_policy" "jenkins_ec2_policy" {
  name   = "jenkins_ec2_policy"
  role   = aws_iam_role.jenkinseks_ec2_role.id
  policy = file("jenkins_ec2_policy.json")
}

resource "aws_iam_role" "jenkinseks_ec2_role" {
  name               = "jenkinseks_ec2_role"
  assume_role_policy = file("jenkins-ec2-assume-policy.json")
}


resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
  name = "jenkinseks_ec2_profile"
  role = aws_iam_role.jenkinseks_ec2_role.name
}


resource "aws_iam_user" "jenkins-eks-terraform" {
  name = "jenkins-eks-terraform"
}

resource "aws_iam_access_key" "jenkins-eks-terraform-key" {
  user = aws_iam_user.jenkins-eks-terraform.name
}

resource "aws_iam_user_policy" "jenkins-eks-terraform-policy" {
  user   = aws_iam_user.jenkins-eks-terraform.name
  name   = "jenkins_ec2_policy"
  policy = file("jenkins_ec2_policy.json")

}


