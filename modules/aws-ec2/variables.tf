variable "create" {
  description = "(Optional) Set to False to disable creation of this stack"
  default     = "true"
}

variable "name" {
  description = "(Required) The common name to be used when naming resources"
  type        = string
}

variable "hostname_prefix" {
  description = "(Optional) A prefix to be used for defining the hostname. Can be used with multiple instances."
  default     = ""
}

variable "register_dns" {
  description = "(Optional) Set to true to create DNS records for the instances"
  default     = false
}

variable "domain_name" {
  description = "(Optional) The name of the local domain to register the instance into"
  default     = ""
}

variable "dns_zone" {
  description = "(Required) The DNS zone id"
  default     = ""
}

variable "dns_ttl" {
  description = "(Optional) The TTL for the DNS record."
  default     = 600
}

variable "ami" {
  description = "(Required) The AMI image to use when deploying the instance"
  type        = string
}

variable "instance_type" {
  description = "(Required) Specifies the instance type"
  type        = string
}

variable "user_data" {
  description = "(Optional) User data for the deployed instances"
  default     = " "
}

variable "iam_instance_profile" {
  description = "(Optional) A IAM instance profile to associate with the deployed instances"
  default     = ""
}

variable "ssh_key" {
  description = "(Required) The SSH key to be deployed to instances"
  type        = string
}

variable "ssh_port" {
  description = "(Optional) The TCP port to use for SSH"
  default     = 22
}

variable "ssh_source_restriction" {
  description = "(Required) security group id allowed to connect via SSH to instances."
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "(Optional) List if CIDRs to allow ssh access to"
  default     = []
}

variable "vpc_id" {
  description = "(Required) The VPC Id where resources will be created"
  type        = string
}

variable "subnet_ids" {
  description = "(Required) The subnet IDs where instances will be deployed"
  type        = list(string)
}

variable "enable_monitoring" {
  description = "(Optional) Enable detailed monitoring"
  default     = false
}

variable "public" {
  description = "(Optional) Whether the instances should be public (a private IP will be assigned)"
  default     = false
}

variable "private_ips" {
  description = "(Optional) A list of private IP to assign to deployed instances"
  default     = []
}

variable "root_vol_type" {
  description = "(Optional) The type of the root volume. Can be one of 'standard', 'gp2', 'io1'"
  default     = "gp2"
}

variable "root_vol_size" {
  description = "(Optional) The size of the root volume in GiB"
  default     = 10
}

variable "security_groups" {
  description = "(Optional) Additional security groups to associate with the instances."
  default     = []
}

variable "allow_icmp" {
  description = "(Optional) Set to true to enable ICMP for troubleshooting purposes"
  default     = false
}

variable "tags" {
  description = "(Optional) Tags to be added to created resources"
  default     = {}
}

