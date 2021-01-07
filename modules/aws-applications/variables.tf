# variables.tf ~ Defines global vars for the project

############################################
## AWS ACCOUNT RELATED VARIABLES
############################################

variable "setup_mode" {
  description = "(Optional) Flag to disable some resources when not all dependecies can be satisfied"
  type        = string
  default     = "false"
}

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

# AMI images
variable "ami" {
  description = "(Required) AWS AMIs used as base images"
  type        = map(string)
}

variable "ssh_keys" {
  description = "(Required) A map with SSH keys to be used when creating EC2 instances"
  type        = map(string)
}

## Tags
variable "common_tags" {
  description = "(Required) Tags to apply to every resource. Environment specific."
  type        = map(string)
}

variable "drupal_build_number" {
  description = "Build number which identify a version"
  default     = "0.0.1"
}

variable "ed-drupal_build_number" {
  description = "Build number which identify a version"
  default     = "0.0.1"
}

############################################
## VPC NETWORKING
############################################

## PROTOCOLS

variable "enable_icmp" {
  description = "(Optional) Enable ICMP for VPC management traffic"
  default     = false
}

## SUBNETTING

variable "azs" {
  description = "(Required) Specifies the AWS Availability Zones in which we will deploy resources"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "(Required) CIDR used for the VPC network"
  type        = string
}

variable "public_subnets" {
  type = list(string)
}

variable "web_subnets" {
  type = list(string)
}

variable "cms_subnets" {
  type = list(string)
}

variable "public_subnets_cidr" {
  description = "(Required) List of CIDR ranges for all DMZ subnets"
  type        = list(string)
}

variable "private_web_subnets_cidr" {
  description = "(Required) List of CIDR ranges for all WEB subnets"
  type        = list(string)
}

variable "private_cms_subnets_cidr" {
  description = "(Required) List of CIDR ranges for all CMS subnets"
  type        = list(string)
}

variable "cidrs_jenkins_hosts" {
  description = "(Required) List of CIDR ranges for Jenkins"
  default     = []
}

## VPN
variable "shared_services_pcx" {
  description = "VPN Shard services pcx"
  type        = string
}

############################################
# DNS
############################################

variable "dns_ttl" {
  description = "(Optional) The TTL for Route53 records"
  default     = "3600"
}

/*variable "dns_public_zone_name" {
    description = "(Required) The public DNS zone used to serve site content"
    type = "string"
}*/

variable "dns_public_zone_id" {
  description = "(Required) The public DNS zone id"
  type        = string
}

/*variable "dns_local_zone_name" {
    description = "(Required) Name for the local DNS zone."
    type = "string"
}*/

variable "dns_local_zone_id" {
  description = "(Required) Local DNS zone id"
  type        = string
}

variable "internal_drupal_lb_endpoint" {
  description = "(Optinal) Optional in DEV and QA, required in PREPROD, endpoint of internal drupal LB"
  type        = string
  default     = ""
}

############################################
# Aliases and origins for PREPROD and PROD CDN
############################################
variable "cdn_www_alias" {
  description = "(Optional) Alias for Angular CDN"
  default     = ""
}

variable "cdn_www_aliases" {
  description = "(Optional) Alias for Angular CDN in PREPROD and PROD"
  default     = ""
}

variable "cdn_api_alias" {
  description = "(Optional) Alias for Api-aggregator CDN in PREPROD and PROD"
  type        = string
  default     = ""
}

variable "cdn_docs_alias" {
  description = "(Optional) Alias for CMS CDN in PREPROD and PROD"
  type        = string
  default     = ""
}

variable "cdn_www_origin" {
  description = "(Optional) Origin for Angular CDN in PREPROD and PROD"
  type        = string
  default     = ""
}

variable "cdn_api_origin" {
  description = "(Optional) Origin for Api-aggregator CDN in PREPROD and PROD"
  type        = string
  default     = ""
}

variable "cdn_docs_origin" {
  description = "(Optional) Origin for CMS CDN in PREPROD and PROD"
  type        = string
  default     = ""
}

############################################
## KNOWN IPS
############################################

variable "trusted_parties" {
  description = "(Optional) A list of CIDRs to allow full web access to the site"
  default     = []
}

variable "private_ips" {
  description = "A map of private IPs to assign to specific instances"
  default     = {}
}

variable "oracle_db_ipaddress" {
  description = "(Required) The IP address of the on-premises Oracle DB instance"
}

variable "cidr_vdi_subnets" {
  description = "(Optional) CIDRs of VDI (Citrix) subnets"
  default     = []
}

variable "cidr_jenkins_hosts" {
  description = "(Optional) CIDRs of Jenkins machines running on-prem"
  default     = []
}

variable "cidr_admin_subnets" {
  description = "(Optional) CIDRs of LSEG admin subnets"
  default     = []
}

# List of allowed ip networks and addresses for sg_bastion ingress rules
variable "jumphost_allowed_ips" {
  description = "(Required) Network CIDR ranges to which allow SSH access to the jump host"
  type        = list(string)
}

variable "bastion_allowed_ips" {
  description = "(Required) Network CIDR ranges to which allow SSH access to the jump host"
  type        = list(string)
}

variable "public_access_ips" {
  description = "(Required) Network CIDR ranges to which allow HTTP access to public endpoints"
  type        = list
}

variable "corporate_proxy_ip" {
  description = "(Optional) Comma separated list of proxy IP addresses"
  type        = string
}

variable "corporate_proxy_ips_list" {
  description = "(Required) List of proxy IP addresses to use in r53 record"
  type        = list(string)
}

variable "corporate_proxy_port" {
  description = "(Optional) Proxy port"
  default     = "8082"
}

variable "lsegisapi_endpoint_url" {
  description = "(Required) The URL of the public IssuerServices API endpoints"
  type        = string
}

############################################
## APPLICATIONS CONFIGURATIONS
############################################

variable "drupal_instance_config" {
  default = {}
}

variable "drupal_db_config" {
  default = {}
}

variable "ed-drupal_instance_config" {
  default = {}
}

variable "ed-drupal_db_config" {
  default = {}
}

variable "varnish_instance_config" {
  default = {}
}

variable "bastion_instance_config" {
  default = {}
}

# Beanstalk instances
variable "datatype_instance_config" {
  default = {}
}

variable "angularuniversal_instance_config" {
  default = {}
}

variable "angularpreview_instance_config" {
  default = {}
}

variable "apiaggregator_instance_config" {
  default = {}
}

variable "authserverjwt_instance_config" {
  default = {}
}

variable "mailingtool_instance_config" {
  default = {}
}

variable "usermanagement_instance_config" {
  default = {}
}

variable "newsmanagement_instance_config" {
  default = {}
}

# Mocks and local services
variable "cwsapi_instance_config" {
  default = {}
}

variable "cwsmock_instance_config" {
  default = {}
}

variable "apiaggregator_mock_instance_config" {
  default = {}
}

variable "cws_search_instance_config" {
  default = {}
}

variable "zipkin_instance_config" {
  default = {}
}

############################################
## Instances number
############################################
variable "angular_autoscale_min" {
  default = 1
}
variable "angular_autoscale_max" {
  default = 5
}

variable "angular_preview_autoscale_min" {
    default = 1
}

variable "apiaggregator_autoscale_min" {
    default = 1
}

variable "apiaggregator_autoscale_max" {
    default = 5
}

variable "drupal_autoscale_min" {
    default = 1
}

variable "cache_autoscale_min" {
    default = 1
}

variable "drupal_autoscale_max" {
    default = 2
}

variable "drupal_desired" {
    default = 1
}

variable "cache_desired" {
    default = 1
}


variable "cache_autoscale_max" {
    default = 2
}

variable "authserver_autoscale_min" {
    default = 1
}

variable "authserver_autoscale_max" {
    default = 5
}

variable "datatype_autoscale_min" {
    default = 1
}

variable "datatype_autoscale_max" {
    default = 5
}

variable "mailingtool_autoscale_min" {
    default = 1
}

variable "mailingtool_autoscale_max" {
    default = 5
}

############
# SSL CERTS
############

variable "cloudfront_default_certificate" {
  description = "(Oprional) Define whether the cloudfront has to use its default certificate"
  default     = false
}

variable "www_cdn_ssl_certificate" {
  description = "(Required) The SSL certificate to use with the front-end CloudFront distribution"
}

variable "api_cdn_ssl_certificate" {
  description = "(Required) The SSL certificate to use with the API CloudFront distribution"
}

variable "cms_cdn_ssl_certificate" {
  description = "(Required) The SSL certificate to use with the CMS CloudFront distribution"
}

variable "angular_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Angular ELB public endpoint"
}

variable "angular_preview_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Angular Preview ELB public endpoint"
}

variable "apiaggregator_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with API Aggregator ELB public endpoint"
}

variable "cms_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Varnish/Drupal ELB public endpoint"
}

variable "datatype_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Datatype ELB endpoint"
}

variable "apiaggregatormock_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with API Aggregator ELB public endpoint"
}

variable "authserver_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Auth Server JWT ELB endpoint"
}

variable "mailingtool_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Auth Server JWT ELB endpoint"
}

variable "varnish_public_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Varnish PUBLIC ELB HTTPS listener"
}

variable "drupal_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Drupal ELB HTTPS listener"
}

variable "ed_drupal_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with Drupal ELB HTTPS listener"
}

variable "usermanagement_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with UserManagement HTTPS listener"
}

variable "newsmanagement_ssl_certificate_elb" {
  description = "(Required) The SSL certificate to use with NewsManagement HTTPS listener"
}

variable "elb_stockex_certificate_arn" {
  default = ""
}
############################################
## EXTERNAL DATA
############################################

variable "vpc_id" {
  description = "(Required) The id of the AWS VPC to use when deploying the infrastructure."
}

variable "deploy_bucket" {
  description = "(Required) The S3 bucket used for app deploy"
}

variable "logging_bucket" {
  description = "(Required) The S3 bucket used for logging"
}

variable "website_bucket" {
  description = "(Required) The S3 bucket used for hosting the web site static content"
}

variable "backup_bucket" {
  type        = string
  description = "(Required) The S3 bucket used to backup EFS drupal editor contets"
}

variable "nat_public_ips" {
  type        = list
  description = "(Required) List of public NAT IPs as IPV4 (map) for WAF"
}


# Custom header value to allow access to public ALB

variable "custom_header_waf_access" {
  type      = string
  description = "Custom header value to allow access to public ALB"
  default  = "3svDSN1w6bKlumb5LSpl"
}

#---------------------------------------------------------------
#  EFS
#---------------------------------------------------------------

variable "efs_cwsapi" {
  description = "(Required) The DNS name of the EFS filesystem used for FTSE Analytics on CWS-API"
  type        = string
}

variable "efs_drupal" {
  description = "(Required) The DNS name of the EFS filesystem used for Drupal persistence"
  type        = string
}

variable "efs_ed-drupal" {
  description = "(Required) The DNS name of the EFS filesystem used for Drupal persistence"
  type        = string
}

variable "cws-api_efs_id" {
  description = "(Required) The Id of the EFS filesystem used for FTSE Analytics on CWS-API"
  type        = string
}

variable "drupal_efs_id" {
  description = "(Required) The Id of the EFS filesystem used for Drupal persistence"
  type        = string
}

variable "ed-drupal_efs_id" {
  description = "(Required) The Id of the EFS filesystem used for Drupal persistence"
  type        = string
}

variable "create_jumphost" {
  description = "(Optional) Set to true to enable creation of Jumhost EC2 and security groups."
  default     = "false"
}

# solr on prem
variable "solr_host_name" {
  type        = string
  description = "Solr host name to use in drupal file host"
}

variable "solr_ip" {
  type        = string
  description = "Solr ip to use in drupal file host"
}

# cws api on-prem. Mainly PRE and PROD 
variable "cwsapi_host_name" {
  type        = string
  description = "CWS Api host name to use in drupal file host"
  default     = ""
}

variable "cwsapi_ip" {
  type        = string
  description = "CWS Api ip to use in drupal file host"
  default     = ""
}

variable "virtual_private_gateway_id" {
  type        = string
  description = "(Optional) Virtual private gateway used in routing table"
  default     = ""
}

variable "cet_app_tier_sg_id" {
  type        = string
  description = "(Optional) SG id for App Tier, this SG is created with on-boarding"
  default     = ""
}

variable "dd_url" {
  type        = string
  description = "(Optional) DataDog url"
  default     = ""
}

variable "r53_hosted_zone_env" {
  type        = string
  description = "(Optional) Hosted zone environment string to create r5 records"
  default     = "dev"
}
