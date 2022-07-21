# Policy for nodes in the hashi at home datacentre

# Read secret-id from hashiathom.me AppRole
path "auth/hashiatho.me/role/consul-secrets/secret-id" {
  capabilities = ["create", "read", "update"]
}
# Allow login with Approle
path "auth/hashiatho.me/login" {
  capabilities = ["create", "delete", "read", "update"]
}

# Allow token lookup
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow wrapping token lookup
path "wrapping/lookup" {
  capabilities = ["read", "list"]
}

# Write test data
path "secret/data/hashiatho.me/*" {
  capabilities = ["read", "list"]
}

# List enabled secrets engines
path "sys/mounts" {
  capabilities = ["read", "list"]
}

# Work with PKI secrets engine to issue certs
# This should be protected with a path filter to only issue certs to
# the requestor
path "PKI/hashiatho.me" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Read all secrets at hashiatho.me mount
path "hashiatho.me/*" {
  capabilities = ["read", "list"]
}
