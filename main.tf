resource "proxmox_virtual_environment_container" "container" {
  description = var.description
  tags        = var.tags


  pool_id       = var.pool_id
  node_name     = var.node_name
  vm_id         = var.vm_id
  protection    = var.protection
  start_on_boot = var.start_on_boot
  unprivileged  = var.unprivileged

  memory {
    dedicated = var.memory.dedicated
    swap      = var.memory.swap
  }

  cpu {
    cores = var.cpu_cores
  }

  disk {
    datastore_id = var.disk.storage_name
    size         = var.disk.disk_size
  }

  network_interface {
    bridge      = "vmbr0"
    name        = "eth0"
    vlan_id     = var.is_dmz == true ? 20 : 10
    firewall    = true
    mac_address = var.mac_address == null ? null : var.mac_address
  }

  operating_system {
    template_file_id = var.operating_system.template_file
    type             = var.operating_system.type
  }

  initialization {
    hostname = var.hostname
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys     = [trimspace(var.root.ssh_pub_key)]
      password = var.root.password == null ? random_password.vm.result : var.root.password
    }
  }

  features {
    nesting = true
  }

}

resource "random_password" "vm" {
  length           = 16
  override_special = "_%@"
  special          = true
}

