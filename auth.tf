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
