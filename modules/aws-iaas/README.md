# lse-cws-iaas Terraform Module

Terraform module to deploy a balanced IaaS stack configured for autoscaling.
This will deploy the following configuration

         |
        \|/ HTTPS Listener (:443)
         °
    +---------+
    |   ALB   |
    +---------+
         |
         | HTTP Target Group (:80)
        \|/
         °
      +------+
      | EC2s |-+
      +------+ |-+
       +-------+ |
        +--------+

## Load Balancer

The module will create an Application load balancer with a single HTTPS listener configured for SSL traffic termination.
The default behavior for this listener is to forward requests to the backend instances registered in an HTTP target group.

You can control via module variables the configuration for the Load Balancer, to deploy it private or public, or to tune healthcheck.

## Autoscaling

## Security Groups

This module will create 2 distinct security groups for the ALB (application load balancer) and the back-end EC2 instances.

The only rules that will be created are those to allow traffic from the load balancer and the instances.
Additional rules can be created afterward by referring to the module's 'elb_security_group' output.

### Load Balancer security groups

This module will create a security group for the load balancer with the following rules:

    - HTTP out (tcp:80) to EC2 security group

The load balancer security group will be named according to the following syntax:

    <PRJ>-<ENV>-<APP>-ALB-SG

## SSL

All connections to the load balancer should be HTTPS only (no HTTP listener will be created by this module) and a valid SSL certificate ARN should be specified by using the *ssl_certificate_arn* variable.

SSL termination is at the load balancer, and traffic to backend instances will be HTTP.

## IAM Instance Policies

By default no Instance Policy will be attached to the instances.
You can assign a IAM policy (for logging to CloudWatch for example) by using the *iam_instance_policy* variable.

## CHANGELOG

### LSEAW-3173

* Removed HTTPS on the backend (no more a requisite)
* Added *additional_target_groups* variable to allow having multiple load balancers