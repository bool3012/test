#--------------------------------------------------------------
# AWS
#--------------------------------------------------------------
aws_region = "eu-west-1"
aws_account_id = "194533837047"
aws_account_name = "stormromalab"
aws_profile = "stormromalab"

#--------------------------------------------------------------
# Tags common to all resources
#--------------------------------------------------------------
common_tags = {
    ApplicationName = "CEDACRI"
    Application = "TEST"
    Region = "eu-west-1"
    BusinessCriticality = "-1"
    BusinessDivision = "CORP"
    BusinessUnit = "CEDACRI"
    CostCentre = "CC58419"
    Owner = "aws-lse-cws-dev@lseg.com"
    Terraformed = "true"
}