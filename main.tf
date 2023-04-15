module vpc {
    source = "./modules/vpc"
    environment = var.environment
    is_dns_hostname_enable = var.is_dns_hostname_enable
    instance_tenancy_type  = var.instance_tenancy_type
    cidr_block = var.cidr_block
}