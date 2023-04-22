terraform {
  backend "consul" {
    // address = "sense.station:8500"
    scheme     = "http"
    datacenter = "dc1"
    path       = "hashiatho.me/vault"
  }
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.26.1"
    }
  }
}

provider "vault" {
  # Configuration options
  address            = var.vault_addr
  add_address_to_env = true
  skip_tls_verify    = true
}

resource "vault_mount" "hashiathome-kv-v2" {
  path        = "hashiatho.me-v2"
  type        = "kv-v2"
  description = "KV-V2 secrets for hashiatho.me"
  local       = true
  seal_wrap   = true
}

# Currently Enterprise only
# resource "vault_raft_snapshot_agent_config" "local" {
#   name             = "snaps"
#   file_prefix      = "backup"
#   interval_seconds = 604800
#   retain           = 5
#   path_prefix      = "bak/"
#   storage_type     = "local"
#   local_max_space  = "1000000"
# }
