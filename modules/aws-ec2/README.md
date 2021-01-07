# LSE AWS EC2 Instance Terraform Module

Terraform module which creates CWS EC2 instance(s) on AWS.

## Usage

```hcl
module "cws_simple_instance" {
    source = "./modules/cws_ec2_instance"

    name = "simple-instance"
    instance_count = 1

    ami = ""
    instance_type = ""
    key_name = ""
    monitoring = true
    vpc_security_group_ids = []
    subnet_id = ""

    tags = {
        Terraformed = "true"
        Environment = "dev"
    }
}
```