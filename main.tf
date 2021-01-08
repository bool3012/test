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
  #profile = "default"   
  #version = "~> 2"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/test"
  }
}

#module "my_ec2" {
#  source                 = "./modules/aws-ec2"
#  #version                = "~> 2.0"
#  name                   = "my-ec2"
#  ami                    = "ami-01720b5f421cf0179"
#  instance_type          = "t2.micro"
#  ssh_key                = "azannetti"
#  enable_monitoring      = false
#  public                 = false
#  security_groups        = ["sg-042b175d17b5c31d6"]
#  subnet_ids             = ["subnet-036a9578fadf469d9"]
#  vpc_id                 = "vpc-0c8f0856e8b325c59"
#  ssh_source_restriction = "sg-042b175d17b5c31d6"
#  allow_icmp = true
#  tags = merge(
#    var.common_tags,
#    {
#      "Environment" = "LAB"
#    },
#  )
#}