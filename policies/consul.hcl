# Policy for nodes in the hashi at home datacentre

# Mount the AppRole auth method
path "sys/auth/hashiatho.me" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}
# Policy for consul approle tokens

# Create and manage roles
path "auth/hashiatho.me/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Write ACL policies
path "sys/policies/acl/*" {
  capabilities = ["create", "read", "list"]
}

# Write test data
path "secret/data/hashiatho.me/*" {
  capabilities = ["read", "list"]
}

# List enabled secrets engines
path "sys/mounts" {
  capabilities = ["read", "list"]
}

# Work with PKI secrets engine
path "PKI/hashiatho.me" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
