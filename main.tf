# main.tf ~ Entrypoint

######################################
## TERRAFORM & PROVIDER CONFIGURATION
######################################

terraform {
  required_version = "~> 0.12"
  backend "s3" {
    bucket = var.state_bucket
    key    = var.state_key
    region = var.state_region
  }
}

# AWS default provider
provider "aws" {
  region  = var.aws_region
  version = "~> 2"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/test"
  }
}