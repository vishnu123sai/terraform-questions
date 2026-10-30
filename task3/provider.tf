provider "aws" {
  alias   = "account_a"
  region  = "ap-south-1"
  profile = "account-a"
}

provider "aws" {
  alias   = "account_b"
  region  = "ap-south-1"
  profile = "account-b"
}