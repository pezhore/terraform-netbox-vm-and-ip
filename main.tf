resource "null_resource" "verify" {
  count = (var.reserved_ip == null && var.network_cidr == null) ? 1 : 0
  triggers = {
    always_run = uuid()
  }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-lc"]
    command     = "Requires prefix or reserved ip && exit 1"
  }
}

resource "netbox_virtual_machine" "vm" {
  name         = join(".", [var.vm_name, var.domain])
  cluster_id   = data.netbox_cluster.cluster.id
  comments     = var.vm_comments
  memory_mb    = var.memory_mb
  vcpus        = var.vcpu
  disk_size_gb = var.disk_size_gb
}

resource "netbox_interface" "vm_int" {
  virtual_machine_id = netbox_virtual_machine.vm.id
  name               = var.vm_interface
}

resource "netbox_ip_address" "vm" {
  count        = var.reserved_ip ? 1 : 0
  ip_address   = var.ip_address
  status       = var.ip_status
  dns_name     = join(".", [var.vm_name, var.domain])
  interface_id = netbox_interface.vm_int.id
}

resource "netbox_available_ip_address" "vm" {
  count        = var.reserved_ip ? 0 : 1
  prefix_id    = data.netbox_prefix.prefix[0].id
  status       = var.ip_status
  dns_name     = join(".", [var.vm_name, var.domain])
  interface_id = netbox_interface.vm_int.id
}

resource "netbox_primary_ip" "vm_primary" {
  virtual_machine_id = netbox_virtual_machine.vm.id
  ip_address_id      = var.reserved_ip ? netbox_ip_address.vm[0].id : netbox_available_ip_address.vm[0].id
}