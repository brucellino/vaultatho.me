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
