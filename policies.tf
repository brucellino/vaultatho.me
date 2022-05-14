data "local_file" "read_only_policy" {
  filename = "${path.module}/policies/read-only.hcl"
}

resource "vault_policy" "read_only" {
  name   = "read-only"
  policy = data.local_file.read_only_policy.content
}

# read Nomad monitoring policy from local file
data "local_file" "monitoring_policy" {
  filename = "${path.module}/policies/nomad-monitoring.hcl"
}

# Create Vault policy from nomad monitoring data
resource "vault_policy" "nomad_monitoring" {
  name   = "nomad-monitoring"
  policy = data.local_file.monitoring_policy.content
}
