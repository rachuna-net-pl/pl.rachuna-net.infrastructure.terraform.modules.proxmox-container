## Wymagania

- Terraform w wersji kompatybilnej z modułem
- Środowisko Proxmox VE z dostępem API
- Uprawnienia do tworzenia i zarządzania kontenerami LXC na wskazanym węźle Proxmox

---
## Zmienne wejściowe

| Nazwa             | Typ                | Opis                                                                                  | Wartość domyślna |
|-------------------|--------------------|---------------------------------------------------------------------------------------|------------------|
| `hostname`        | string             | Nazwa hosta kontenera                                                                 | -                |
| `description`     | string             | Opis kontenera                                                                        | null             |
| `node_name`       | string             | Nazwa węzła Proxmox, na którym ma zostać utworzony kontener                           | -                |
| `vm_id`           | number             | ID maszyny wirtualnej (kontenera)                                                    | -                |
| `pool_id`         | string             | Nazwa puli, do której ma należeć kontener                                            | null             |
| `protection`      | bool               | Czy kontener jest chroniony przed przypadkowym usunięciem                            | false            |
| `start_on_boot`   | bool               | Czy kontener ma się uruchamiać automatycznie przy starcie hosta                      | false            |
| `tags`            | list(string)       | Lista tagów przypisanych do kontenera                                                | []               |
| `unprivileged`    | bool               | Czy kontener działa jako nieuprzywilejowany na hoście                                | false            |
| `cpu_cores`       | number             | Liczba rdzeni CPU przydzielonych kontenerowi                                        | 1                |
| `memory`          | object             | Konfiguracja pamięci: `dedicated` (MB), `swap` (MB)                                 | {dedicated=512, swap=512} |
| `disk`            | object             | Konfiguracja dysku: `storage_name` (nazwa magazynu), `disk_size` (GB)                | -                |
| `is_dmz`          | bool               | Czy kontener znajduje się w strefie DMZ (Demilitarized Zone)                         | false            |
| `operating_system` | object             | System operacyjny: `template_file` (ścieżka do szablonu), `type` (np. alpine, ubuntu) | -                |
| `mac_address`     | string             | Adres MAC interfejsu sieciowego kontenera                                           | null             |
| `root`            | object (sensitive) | Konfiguracja konta root: `password` (opcjonalne), `ssh_pub_key` (opcjonalny klucz SSH) | -                |

---
## Przykład użycia

```hcl
module "vm01101-ct" {
    source        = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/proxmox-container.git?ref=poc"

    hostname      = "vm01101-ct"
    description   = "Hashicorp Vault & Consul"
    node_name     = "pve-s1"
    vm_id         = 1101
    pool_id       = "vault-consul"
    protection    = true
    start_on_boot = true
    tags          = ["vault-consul", "alpine"]
    unprivileged  = true
    is_dmz        = true
    
    cpu_cores     = 1
    memory = {
        dedicated = 1024
        swap      = 1024
    }
    disk = {
        storage_name = local.storage_name
        disk_size    = 32
    }
    
    operating_system = {
        template_file = join("/", [local.ct_storage_name, "alpine-3.21.tar.zst"])
        type          = "alpine"
    }

    root = {
        ssh_pub_key = var.technical_user_ssh_pub_key
    }
}
```

---
## Wyjścia

Moduł nie definiuje jawnych wyjść. Informacje o stanie kontenera można uzyskać z zasobów Proxmox VE po zastosowaniu konfiguracji.

---
## Uwagi

- Kontener jest konfigurowany z funkcją nesting włączoną.
- Sieć kontenera jest podłączona do mostka `vmbr0` z VLAN 10 lub 20 w zależności od flagi `is_dmz`.
- Hasło root jest generowane losowo, jeśli nie zostanie podane.
