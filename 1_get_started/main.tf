terraform {

  cloud {
    organization = "iglumtech"

    workspaces {
      name = "getting_started"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}


# ---


locals {
  resource = "Ec2"
  ec2Type  = "Nano"
}

# ---