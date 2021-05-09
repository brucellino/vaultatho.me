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
}

resource "vault_auth_backend" "auto_auth_approle" {
  type        = "approle"
  path        = "hashiatho.me"
  description = "Approle for Hashi@Home nodes"
  tune = {
    default_lease_ttl = "60m"
    max_lease_ttl     = "24h"
    token_type        = "service"
  }
}
