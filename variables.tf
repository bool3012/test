# variables.tf ~ Defines global vars for the project

############################################
## AWS ACCOUNT RELATED VARIABLES
############################################


variable "aws_account_id" {
  description = "(Required) The ID of the AWS Account we will act upon"
  type        = string
}

variable "aws_region" {
  description = "(Required) The AWS Region where resources will be created"
  type        = string
}

variable "aws_profile" {
  description = "(Optional) The name for the awscli profile to use for authentication"
  default     = "default"
}

## AWS account name
variable "aws_account_name" {
  description = "(Required) The name of the AWS account"
  type        = string
}

############################################
## GENERAL VARIABLES
############################################

## Tags
variable "common_tags" {
  description = "(Required) Tags to apply to every resource. Environment specific."
  type        = map(string)
}