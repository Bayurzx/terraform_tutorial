
provider "aws" {
  profile = "terraform" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}

provider "aws" {
  profile = "terraform" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "eu-west-1"
  alias   = "europe"
}
