resource "vault_mount" "hashiathome-kv-v2" {
  path        = "hashiatho.me-v2"
  type        = "kv-v2"
  description = "KV-V2 secrets for hashiatho.me"
  local       = true
  seal_wrap   = true
}
