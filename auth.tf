# Authentication backends for Vault
# AppRole for hashi@home instances
resource "vault_auth_backend" "auto_auth_approle" {
  type        = "approle"
  path        = "hashiatho.me"
  description = "Approle for Hashi@Home nodes"
  tune {
    default_lease_ttl = "60m"
    max_lease_ttl     = "24h"
    token_type        = "service"
  }
}

resource "vault_auth_backend" "gh_approle" {
  type        = "approle"
  path        = "github-runners"
  description = "Approle for Github Actions runners"

  tune {
    default_lease_ttl = "10m"
    max_lease_ttl     = "10m"
    token_type        = "service"
  }
}
# We need to get the ip ranges of github actions ips from github
# in order to bind the approle cidrs later.
data "github_ip_ranges" "actions" {}

# Role for  github actions runners. They should read only
resource "vault_approle_auth_backend_role" "gh_runners" {
  backend               = vault_auth_backend.gh_approle.path
  role_name             = "aws"
  secret_id_bound_cidrs = data.github_ip_ranges.actions.actions_ipv4
  token_policies        = [vault_policy.aws.name]
}

moved {
  from = vault_approle_auth_backend_role.aws
  to   = vault_approle_auth_backend_role.gh_runners
}

# Catch-all role for approle auth bound to access point CIDR
resource "vault_approle_auth_backend_role" "catch_all" {
  backend   = vault_auth_backend.auto_auth_approle.path
  role_name = "catch-all"

  secret_id_bound_cidrs = ["0.0.0.0/0"]
  secret_id_ttl         = 600
  bind_secret_id        = false

  # token arguments
  token_policies = ["default", "nomad-read", "nomad-monitoring"]
  token_num_uses = 0
  token_ttl      = 3600
  token_max_ttl  = 10800
  token_type     = "service"
}

resource "vault_approle_auth_backend_role" "consul" {
  backend               = vault_auth_backend.auto_auth_approle.path
  role_name             = "consul-secrets"
  secret_id_bound_cidrs = ["0.0.0.0/0"]
  token_policies        = ["consul"]
  token_num_uses        = 0
  bind_secret_id        = false
}

resource "vault_github_auth_backend" "hah" {
  path         = "github"
  organization = var.github_organization

}

# Role for nomad servers to authenticate and issue themselves certs
# resource "vault_approle_auth_backend_role" "nomad_server" {
#   backend               = vault_auth_backend.auto_auth_approle.path
#   role_name             = "nomad-servers"
#   secret_id_bound_cidrs = ["192.168.1.1/24"]
#   token_policies        = [vault_policy.nomad_read.name, vault_policy.nomad_tls.name]
#   token_num_uses        = 0
#   bind_secret_id        = false

# }
