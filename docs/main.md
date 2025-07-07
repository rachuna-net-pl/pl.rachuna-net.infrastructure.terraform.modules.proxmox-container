## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.76.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.76.1 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_container.container](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container) | resource |
| [random_password.vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores to allocate to the container | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the container | `string` | `null` | no |
| <a name="input_disk"></a> [disk](#input\_disk) | The disk configuration for the container | <pre>object({<br/>    storage_name = string<br/>    disk_size    = number<br/>  })</pre> | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname of the container | `string` | n/a | yes |
| <a name="input_is_dmz"></a> [is\_dmz](#input\_is\_dmz) | Whether the container is in a DMZ (Demilitarized Zone) | `bool` | `false` | no |
| <a name="input_mac_address"></a> [mac\_address](#input\_mac\_address) | The MAC address of the container's network interface | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The memory configuration for the container | <pre>object({<br/>    dedicated = number<br/>    swap      = number<br/>  })</pre> | <pre>{<br/>  "dedicated": 512,<br/>  "swap": 512<br/>}</pre> | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The name of the node to create the container on | `string` | n/a | yes |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The operating system to install on the container | <pre>object({<br/>    template_file = string<br/>    type          = string<br/>  })</pre> | n/a | yes |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | The name of the pool to create the container in | `string` | `null` | no |
| <a name="input_protection"></a> [protection](#input\_protection) | Whether the container is protected from accidental deletion | `bool` | `false` | no |
| <a name="input_root"></a> [root](#input\_root) | The root configuration for the container | <pre>object({<br/>    password    = optional(string)<br/>    ssh_pub_key = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_start_on_boot"></a> [start\_on\_boot](#input\_start\_on\_boot) | The startup behavior of the container | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the container | `list(string)` | `[]` | no |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | Whether the container runs as unprivileged on the host | `bool` | `false` | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | The ID of the VM | `number` | n/a | yes |

## Outputs

No outputs.
