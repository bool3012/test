/*output "source_vpc_id" {
    value = "${data.external.vpc_id.result}"
}*/

# output "vpcIdFromExternalScript" {
#     value = "${data.external.read_infra_state.result["vpc_id"]}"  #lookup(, var.app_name, "latest")}"
# }

# output "public_subnets" {
#     value = "${split(",", data.external.read_infra_state.result["public_subnets"])}"
# }

/*output "vpcIdFromDataSource" {
    value = "${data.aws_vpc.vpc.id}"
}
*/
output "sn" {
  value = var.public_subnets
}

/*
#------------------------------------------------------------------------


######################
## OUTPUT VARIABLES ##
######################

//---------------------------------------------------
// WEB DISTRIBUTIONS

output "endpoint Angular CDN" {
   value = "${aws_cloudfront_distribution.cdn_website.domain_name}"
}
output "endpoint ApiAggregator CDN" {
	value = "${aws_cloudfront_distribution.cdn_api.domain_name}"
}

output "Endpoint CMS docs CDN" {
	value = "${aws_cloudfront_distribution.cdn_docs.domain_name}"
}

//---------------------------------------------------
// JUMP HOST
output "bastion_public_endpoint"    { value = "${aws_route53_record.bastion_public.fqdn} (${module.bastion.public_ip}:22)" }

//---------------------------------------------------
// DRUPAL STACK
output "drupal_dns_name"					{ value = "${module.drupal.dns_fqdn}" }

//---------------------------------------------------
// DATATYPE
output "datatype_load_balancers"			{ value = "${element(module.datatype.load_balancers, 0)}" }
output "datatype_dns_name"					{ value = "${module.datatype.dns_fqdn}" }

//---------------------------------------------------
// ANGULAR
output "angular_dns_name"					{ value = "${module.angular.dns_fqdn}" }

//---------------------------------------------------
// API AGGREGATOR
output "api-aggregator_dns_name"			{ value = "${module.apiaggregator.dns_fqdn}" }
output "api-aggregator_load_balancers"		{ value = "${element(module.api_aggregator.load_balancers, 0)}" }

//---------------------------------------------------
// API AGGREGATOR MOCK

output "api-aggregator_mock_dns_name"		{ value = "${module.apiaggregatormock.dns_fqdn}" }


//---------------------------------------------------
// API AGGREGATOR MOCK

output "usermanager_dns_name"		{ value = "${module.usermanager.dns_fqdn}" }


*/
