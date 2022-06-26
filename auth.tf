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
resource "vault_approle_auth_backend_role" "aws" {
  backend               = vault_auth_backend.gh_approle.path
  role_name             = "aws"
  secret_id_bound_cidrs = data.github_ip_ranges.actions.actions_ipv4
  token_policies        = [vault_policy.aws.name]

}

# Catch-all role for approle auth bound to access point CIDR
resource "vault_approle_auth_backend_role" "catch_all" {
  backend               = vault_auth_backend.auto_auth_approle.path
  role_name             = "catch-all"
  secret_id_bound_cidrs = ["192.168.1.1/24"]
  token_policies        = ["default"]
  token_num_uses        = 0
}

# Add secret ID for the catch-all role
resource "vault_approle_auth_backend_role_secret_id" "catch_all_id" {
  backend      = vault_auth_backend.auto_auth_approle.path
  role_name    = vault_approle_auth_backend_role.catch_all.role_name
  wrapping_ttl = "120s"
  metadata     = <<EOT
{
  "hello": "world"
}
EOT
}
