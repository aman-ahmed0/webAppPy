variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  default     = "ami-08b5b3a93ed654d19"
}

variable "ssh_key_name" {
  description = "SSH key pair name for EC2 instance"
  default     = "my-aws-key"
}
#