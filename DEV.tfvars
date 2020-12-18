#--------------------------------------------------------------
# AWS
#--------------------------------------------------------------
aws_region = "eu-west-1"
aws_account_id = "194533837047"
aws_account_name = "stormromalab"

#--------------------------------------------------------------
# Tags common to all resources
#--------------------------------------------------------------
common_tags = {
    #ApplicationName = "CEDACRI"
    Application = "TEST"
    Environment = "DEV"         # PROD,CDS,TEST,DEV,POC
    Region = "eu-west-1"
    BusinessCriticality = "-1"
    BusinessDivision = "CORP"
    BusinessUnit = "CEDACRI"
    CostCentre = "CC58419"
    Owner = "aws-lse-cws-dev@lseg.com"
    #ProjectCode = "40234"
    Terraformed = "true"
    #ApplicationID = "APP-00063"
    #ManagedBy = Only CET managed resources  
    #Automation = for start/stop automations 
    #LegalEntity = "LSE PLC"
}