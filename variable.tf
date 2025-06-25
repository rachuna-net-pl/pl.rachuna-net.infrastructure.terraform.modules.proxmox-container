variable "hostname" {
  description = "The hostname of the container"
  type        = string
}

variable "description" {
  description = "The description of the container"
  type        = string
  default     = null
}

variable "node_name" {
  description = "The name of the node to create the container on"
  type        = string
}

variable "vm_id" {
  description = "The ID of the VM"
  type        = number
}

variable "pool_id" {
  description = "The name of the pool to create the container in"
  type        = string
  default     = null
}

variable "protection" {
  description = "Whether the container is protected from accidental deletion"
  type        = bool
  default     = false
}

variable "start_on_boot" {
  description = "The startup behavior of the container"
  type        = bool
  default     = false
}

variable "tags" {
  description = "The tags to assign to the container"
  type        = list(string)
  default     = []
}

variable "unprivileged" {
  description = "Whether the container runs as unprivileged on the host"
  type        = bool
  default     = false

}

variable "cpu_cores" {
  description = "The number of CPU cores to allocate to the container"
  type        = number
  default     = 1
}

variable "memory" {
  description = "The memory configuration for the container"
  type = object({
    dedicated = number
    swap      = number
  })
  default = {
    dedicated = 512
    swap      = 512
  }
}

variable "disk" {
  description = "The disk configuration for the container"
  type = object({
    storage_name = string
    disk_size    = number
  })
}

variable "is_dmz" {
  description = "Whether the container is in a DMZ (Demilitarized Zone)"
  type        = bool
  default     = false
}

variable "operating_system" {
  description = "The operating system to install on the container"
  type = object({
    template_file = string
    type          = string
  })

  # The type of the operating system to install on the container
  # alpine - Alpine.
  # archlinux - Arch Linux.
  # centos - CentOS.
  # debian - Debian.
  # devuan - Devuan.
  # fedora - Fedora.
  # gentoo - Gentoo.
  # nixos - NixOS.
  # opensuse - openSUSE.
  # ubuntu - Ubuntu.
  # unmanaged - Unmanaged.

}

variable "mac_address" {
  description = "The MAC address of the container's network interface"
  type        = string
  default     = null
}

variable "root" {
  description = "The root configuration for the container"
  type = object({
    password    = optional(string)
    ssh_pub_key = optional(string)
  })
  sensitive = true
}
