# Create Nomad secrets mount for all deployments
resource "vault_nomad_secret_backend" "catch_all" {
  backend                   = "nomad"
  path                      = "nomad"
  description               = "Nomad default secrets"
  default_lease_ttl_seconds = "3600"
  max_lease_ttl_seconds     = "86400"

}



# Create Vault policy from nomad monitoring data
resource "vault_policy" "nomad_monitoring" {
  name   = "nomad-monitoring"
  policy = file("${path.module}/policies/nomad-monitoring.hcl")
}
