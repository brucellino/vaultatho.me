resource "vault_consul_secret_backend" "consul" {
  path                      = var.consul_backend_path
  address                   = var.consul_http_addr
  description               = "Consul Tokens Path"
  bootstrap                 = false
  token                     = var.consul_token
  default_lease_ttl_seconds = 300
  max_lease_ttl_seconds     = 600
}

resource "vault_consul_secret_backend_role" "cluster" {
  name            = "cluster-role"
  backend         = vault_consul_secret_backend.consul.path
  consul_policies = ["backup-policy"]
  ttl             = 60
  max_ttl         = 300
}
