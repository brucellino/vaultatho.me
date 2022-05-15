resource "vault_policy" "read_only" {
  name   = "read-only"
  policy = file("${path.module}/policies/read-only.hcl")
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("${path.module}/policies/admin.hcl")
}
