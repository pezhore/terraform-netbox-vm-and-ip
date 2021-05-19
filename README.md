# Terraform Netbox IP/VM Resource

Terraform module which creates a VM object in Netbox, and associates a generated IP address from the given cidr network. It can be used as a standard deployment tooling to ensure consistently deployed infrastructure.

This module performs the following actions:

* Retrieves an existing prefix from Netbox that matches the `network_cidr` variable
* Creates a new VM in netbox (and a subsequent interface) based on the provided vars
* Gets the next available IP address from the discovered prefix
* Associates the newly reserved IP with the Netbox VM/Interface

## Requirements

* Provider configuration for `netbox`, and have the custom provider.

```
provider "netbox" {
  server_url  = "https://netbox.domain.local/"
  api_token = "1cbeea...06c9a"
}
```

## Terraform versions

Only tested/supported on 0.15.x

## Usage

### Single VM with a pre-determine IP
```hcl
module "nb" {
  source  = "pezhore/vm-and-ip/netbox"
  version = "0.1.0"

  # Optionals with their defaults
  virtual_cluster = "Cluster01"
  domain          = "domain.local"
  vm_comments     = "Created with Netbox Terraform Provider"
  vm_interface    = "ens160"
  ip_status       = "active"
  memory_mb       = 8192
  vcpu            = 2
  disk_size_gb    = 16

  # Required variables
  vm_name     = "newvm"
  reserved_ip = true # If reserved_ip is true, expect an ip_address
  ip_address  = "10.0.0.50/24"
}
```

### Single VM with the next available IP

```hcl
module "nb" {
  source  = "pezhore/vm-and-ip/netbox"
  version = "0.1.0"

  # Optionals with their defaults
  virtual_cluster = "Cluster01"
  domain          = "domain.local"
  vm_comments     = "Created with Netbox Terraform Provider"
  vm_interface    = "ens160"
  ip_status       = "active"
  memory_mb       = 8192
  vcpu            = 2
  disk_size_gb    = 16

  # Required variables
  vm_name      = "modtest"
  reserved_ip  = false           # If reserved_ip is false, expect an network_cidr
  network_cidr = "10.0.0.0/24" # in this case, the next available IP address in this network will be selected.
}
```