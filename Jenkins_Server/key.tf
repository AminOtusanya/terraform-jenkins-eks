resource "aws_key_pair" "jenkins-server-key" {
  key_name   = "jenkins-server-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "jenkins-server-key"

}