# Paths which jobs will request secrets at.
path "hashiatho.me-v2" {
  capabilities = ["read", "list"]
}

path "hashiatho.me-v2/" {
  capabilities = ["read", "list"]
}
path "hashiatho.me-v2/*" {
  capabilities = ["read", "list"]
}
