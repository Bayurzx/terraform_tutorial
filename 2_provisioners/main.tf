terraform {
  cloud {
    organization = "iglumtech"

    workspaces {
      name = "Providers"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

provider "aws" {
  # profile    = "terraform" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

# data "external" "get_system_ip" {
#   program = ["bash", "-c", "./Get_IP.sh"]
#   # program = ["sh", "-c", "curl -s ifconfig.me"]
# }

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}


resource "aws_instance" "myEc2Demo" {
  ami           = var.ami_aws # Ubuntu Linux in us-east-1, update as per your region
  instance_type = var.instance_type
  key_name = "${aws_key_pair.SSH_to_ec2.key_name}"
  vpc_security_group_ids = [ aws_security_group.sg_myEc2Demo.id ]
  # user_data = data.template_file.user_data.rendered
  user_data = file("userdata.yaml")

  tags = {
    name = "MyEc2Nano"
  }
}

resource "aws_key_pair" "SSH_to_ec2" { # installs our ssh key at our server for us
  key_name   = "SSH_to_ec2-key" 
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkx1YX0qImfN6Da1vjirLLn9VihC0D5+D7gFyvxk37FvtI++i8cWjv8gAQRYyzzdRk1ET67qVCPp8gKYmweRvAaAO3UW4tbAe90rUI9dbqyVNRihs0hx2O9pMrlyZY97hyyDgFkOkAMJyDbqlO0i2R+usybuTtN5dzxdx+Wvz1CFzqgOh/zHA9OFdXNhgLcbbujg2Uo208YRv3uTPOwVv6/7J3TQNXgFaStcXdOib/6jUuT/iywn7/ur9rb9789rR7PAmq6h2mp09XDj691LD6MKPjFWPZx1H9n4QBhD/5OTQFuKAiAItJtBulj041X5nfj0IbGS9BYRSrtti+CF9vr+TtNtE6n7oaaN3Gbhf0kYzS/+CxCaOa4z8YBPsqyqdu5QcHYXXwpK2ogKQIw7vvyeqDOEQr9ZC724WYindiQmjssi4DQfXlvReZolLOciorEZsquLgBzVI+d7bVVlq+8Re9f44ORcXs6PCRfNOZ8OGpS0NGDK9DPfruBoVHqhs= user@BAYURZX"
}

resource "aws_security_group" "sg_myEc2Demo" {
  name        = "sg_myEc2Demo"
  description = "Security Group to Allow HTTP traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["105.112.154.83/32"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress { # By default we do not allow egress.
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


output "public_ip" {
  value = aws_instance.myEc2Demo.public_ip
}

# output "ext_ip" {
#   value = data.external.get_system_ip.result.public_ip
# }
