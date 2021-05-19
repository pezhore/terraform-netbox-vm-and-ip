data "netbox_prefix" "prefix" {
  count = var.reserved_ip ? 0 : 1
  cidr  = var.network_cidr
}

data "netbox_cluster" "cluster" {
  name = var.virtual_cluster
}