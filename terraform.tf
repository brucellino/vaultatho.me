terraform {
  required_version = "1.14.3"
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
