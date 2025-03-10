provider "aws" {
  region = var.aws_region
}
/*
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name

  tags = {
    Name = "FreeTierEC2"
  }
}
*/
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}