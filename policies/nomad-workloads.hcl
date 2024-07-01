path "kv/data/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_job_id}}/*" {
  capabilities = ["read"]
}

path "kv/data/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_job_id}}" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/*" {
  capabilities = ["list"]
}

path "kv/metadata/*" {
  capabilities = ["list"]
}

# Read cloudflare secrets - we need to know the R2 S3 API secrets
path "cloudflare/data/*" {
  capabilities = ["read"]
}

path "hashiatho.me-v2/data/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_job_id}}/*" {
  capabilities = ["read"]
}

path "hashiatho.me-v2/data/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_job_id}}" {
  capabilities = ["read"]
}

path "hashiatho.me-v2/metadata/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/*" {
  capabilities = ["list"]
}

path "hashiatho.me-v2/metadata/*" {
  capabilities = ["list"]
}

# Paths which jobs will request secrets at.
path "hashiatho.me-v2/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_namespace}}/{{identity.entity.aliases.auth_jwt_b998f16c.metadata.nomad_job_id}}/*" {
  capabilities = ["read", "list"]
}

path "hashiatho.me-v2/data/hah_state_backup/*" {
  capabilities = ["read", "list"]
}

path "github_personal_tokens/token" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki_hah_int/issue/hah_int_role" {
  capabilities = ["update", "list"]
}

# create consul tokens
path "hashi_at_home/creds/cluster-role" {
  capabilities = ["read"]
}

# create nomad tokens
path "nomad/creds/mgmt" {
  capabilities = ["read"]
}

# create snapshots
path "sys/storage/raft/snapshot" {
  capabilities = ["read"]
}
