terraform {
  backend "consul" {
    // address = "sense.station:8500"
    scheme     = "http"
    datacenter = "dc1"
    path       = "hashiatho.me/vault"
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