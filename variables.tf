variable environment {
  description = "Environment Value"
  default = "staging"
  type = string
}

variable is_dns_hostname_enable {
  description = "DNS Hostname Enable/Disable flag"
  default = true
  type = bool
}

variable instance_tenancy_type {
  description = "Instance Tenancy Types"
  default = "default"
  type = string

  validation {
    condition     = contains(["default, dedicated"], var.instance_tenancy_type)
    error_message = "Valid values for var: instance_tenancy_type  are (default, dedicated)."
  } 
}

variable cidr_block {
  description = "VPC CIDR Block"
  default = "10.0.0.0/16"
  type = string
}