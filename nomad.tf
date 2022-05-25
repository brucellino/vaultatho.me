# Create Nomad secrets mount for all deployments
resource "vault_nomad_secret_backend" "catch_all" {
  backend                   = "nomad"
  description               = "Nomad default secrets"
  address                   = "http://nomad.service.consul:4646"
  default_lease_ttl_seconds = "3600"
  max_lease_ttl_seconds     = "86400"
}

# Create vault role for the nomad backend to issue tokens for nomad jobs
resource "vault_nomad_secret_role" "catch_all" {
  backend  = vault_nomad_secret_backend.catch_all.backend
  role     = "nomad_catch_all"
  type     = "client"
  policies = ["nomad-monitoring", "nomad-read", "nomad-tls"]
}


# Create Vault policy from nomad monitoring data
resource "vault_policy" "nomad_monitoring" {
  name   = "nomad-monitoring"
  policy = file("${path.module}/policies/nomad-monitoring.hcl")
}

# Vault policy for nomad to read kv data for deployments
resource "vault_policy" "nomad_read" {
  name   = "nomad-read"
  policy = <<EOT
  # Nomad agents can read all secrets in hashiatho.me-v2 mount
  path "${vault_mount.hashiathome-kv-v2.path}/*" {
    capabilities = ["read", "list"]
  }
  EOT
}

# Vault policy for nomad agents to issue themselves TLS certificates
resource "vault_policy" "nomad_tls" {
  name   = "nomad-tls"
  policy = <<EOT
  # Nomad agents agents can request TLS certificates from the intermediate CA
  path "${vault_mount.hah_pki_int.path}/issue/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
  }
  EOT
}
