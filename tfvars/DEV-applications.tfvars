#--------------------------------------------------------------
# Applications configuration
#--------------------------------------------------------------

bastion_instance_config = {
  ami_image       = "bastion"
  instance_type   = "t3.micro"
  root_disk_type  = "gp2"
  root_disk_size  = 8
}
