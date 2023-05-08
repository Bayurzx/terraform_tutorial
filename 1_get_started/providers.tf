
provider "aws" {
  # profile    = "terraform" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

provider "aws" {
  # profile    = "terraform" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region     = "eu-west-1"
  alias      = "europe"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
