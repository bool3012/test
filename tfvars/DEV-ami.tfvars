#-------------------------------
# AMI IMAGES (EU-WEST-2)
#-------------------------------
ami = {
    # AWS standard AMIs
    amznlnx  = "ami-0cfbf4f6db41068ac"   # Amazon Linux 2018.03 HVM standard image
    amznlnx2 = "ami-034fffcc6a0063961"   # Amazon Linux 2 HVM standard image
    rh-Linux = "ami-c86c3f23"            # RHEL 7.5 HVM image

    # LSE custom AMIs 

    rh-drupal   = "ami-0a95da2ff1ca854f8"   # Packed from CET's golden ami redhat_linux_cis 20.02.2020
    rh-varnish  = "ami-0e6934abef0f26e71"   # Packed from CET's golden ami redhat_linux_cis 20.02.2020

    rh-tomcat   = "ami-0a98fcec15cdb213a"   # Packed from CET's golden Amazon Linux ami 16.10.2019
    bastion     = "ami-01b7cdee51a89f4df"   # Packed from CET's golden Amazon Linux ami 16.10.2019

    #jumphost    = "ami-03702c2c2ff02187e"   # JUMPHOST.AMZLNX.2008.03.20181023.01-AMI
    #bastion2    = "ami-02a88880e662cda38"
}

