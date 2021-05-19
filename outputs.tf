output "vm_ip" {
  description = "Assigned IP Address for the given VM in CIDR notation"
  value       = var.reserved_ip ? netbox_ip_address.vm[0].ip_address : netbox_available_ip_address.vm[0].ip_address
}

output "vm_id" {
  description = "Netbox ID given to the new VM"
  value       = netbox_virtual_machine.vm.id
}