# main.tf ~ Entrypoint

######################################
## TERRAFORM & PROVIDER CONFIGURATION
######################################

terraform {
  required_version = "~> 0.11"

  # We are using partial backend configuration. See the README for details.
  # We are using partial backend configuration. See the README for details.
  backend "s3" {
  }
}

# AWS default provider
provider "aws" {
  region  = var.aws_region
  version = "~> 2"
  profile = var.aws_profile
}

# AWS provider for the us-east-1 AWS Region (N. Virginia)
# This is used for subscribing to Amazon SNS (eg. to update CloudFront security groups)
provider "aws" {
  alias   = "us-east"
  region  = "us-east-1"
  version = "~> 2"
}

######################################
## CREATE LOCAL VARS
######################################
locals {
  env = upper(var.common_tags["Environment"])

  # True when working in DEV or QA environments
  is_dev_qa = local.env == "DEV" || local.env == "QA" ? true : false

  # A common prefix used to build names and tags (es: "CWS-QA")
  common_prefix = upper(
    format(
      "%s-%s",
      var.common_tags["Application"],
      substr(local.env, 0, min(3, length(local.env))),
    ),
  )
}

