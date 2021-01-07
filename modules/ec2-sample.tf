provider "aws" {
  region = "eu-west-1"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "my-cluster"
  instance_count         = 1

  ami                    = "ami-0b4b2d87bdd32212a"
  instance_type          = "t2.micro"
  key_name               = "TerraformKeyPair"
  monitoring             = true
  vpc_security_group_ids = ["sg-03d3abe34b99c8c9d"]
  subnet_id              = "subnet-0e5ce9e727ee26112"

  tags = {
    Terraform   = "true"
    Environment = "LAB"
  }
}