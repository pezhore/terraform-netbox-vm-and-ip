variable "reserved_ip" {
  description = "True if an IP address has already been pre-determined."
  type        = bool
}
variable "network_cidr" {
  description = "Network address in CIDR notation"
  type        = string
  default     = null
}

variable "ip_address" {
  description = "IP Address previously defined or reserved. Used for specifically choosing an IP."
  type        = string
  default     = null
}

variable "virtual_cluster" {
  description = "Netbox's virtual cluster for this new vm"
  type        = string
}

variable "domain" {
  description = "Domain used for creating fqdn in netbox for the new VM"
  type        = string
}

variable "vm_comments" {
  description = "Comments for the netbox vm"
  default     = "Created with Netbox Terraform Provider"
}

variable "vm_interface" {
  description = "Default interface for the new VM"
  default     = "ens160"
}

variable "ip_status" {
  description = "Status of the new IP (must be active, reserved, deprecated, dhcp, or slaac)"
  default     = "active"
}

variable "memory_mb" {
  description = "Memory of the VM in MB"
  type        = number
}

variable "vcpu" {
  description = "vCPU count for the VM"
  type        = number
}

variable "disk_size_gb" {
  description = "Total Disk Size in GB"
  type        = number
}

variable "vm_name" {
  description = "Name for the new VM"
  type        = string
}
