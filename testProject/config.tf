provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "yaremchuk.terraform"
    key = "test_infrastructure/dev/terraform.tfstate"
    region = "eu-central-1"
  }
}
