#"${element(concat(aws_vpc.front.*.cidr_block, list("")), 0)}"
output "id" {
  value = element(concat(aws_instance.instance.*.id, [""]), 0)
}

output "public_dns" {
  value = element(concat(aws_instance.instance.*.public_dns, [""]), 0)
}

output "public_ip" {
  value = element(concat(aws_instance.instance.*.public_ip, [""]), 0)
}

# TODO Not used, may be deleted...
# output "network_interface_id" {
# 	value = "${element(concat(aws_instance.instance.*.network_interface_id, list("")), 0)}"
# }

output "private_dns" {
  value = element(concat(aws_instance.instance.*.private_dns, [""]), 0)
}

output "private_ip" {
  value = element(concat(aws_instance.instance.*.private_ip, [""]), 0)
}

output "security_groups" {
  value = aws_instance.instance.*.vpc_security_group_ids
}

output "ec2_security_group" {
  value = element(concat(aws_security_group.ec2.*.id, [""]), 0)
}

output "subnet_id" {
  value = element(concat(aws_instance.instance.*.subnet_id, [""]), 0)
}

output "ssh_port" {
  value = var.ssh_port
}

/*
output "root_block_devices" {
	value = "${element(concat(aws_instance.instance.root_block_device.*.volume_id, list("")), 0)}"
}

output "ebs_block_devices" {
	value = "${element(concat(aws_instance.instance.ebs_block_device.*.volume_id, list("")), 0)}"
}
*/

output "dns_fqdn" {
  value = element(concat(aws_route53_record.instance.*.fqdn, [""]), 0)
}

