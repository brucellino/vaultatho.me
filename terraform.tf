terraform {
  required_version = "1.16.1"
  backend "consul" {
    // address = "sense.station:8500"
    scheme     = "http"
    datacenter = "dc1"
    path       = "hashiatho.me/vault"
  }
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5"
    }
  }
}



provider "vault" {
  # Configuration options
  add_address_to_env = true
  skip_tls_verify    = true
}
