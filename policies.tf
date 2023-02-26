resource "vault_policy" "read_only" {
  name   = "read-only"
  policy = file("${path.module}/policies/read-only.hcl")
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("${path.module}/policies/admin.hcl")
}

# policy to read aws credentials. Generally scoped to A cloud guru playgrounds
resource "vault_policy" "aws" {
  name   = "aws_acg"
  policy = file("${path.module}/policies/aws_acg.hcl")
}

resource "vault_policy" "consul" {
  name = "consul"
  policy = templatefile("${path.module}/policies/consul.hcl.tmpl", {
    approle_path = vault_auth_backend.auto_auth_approle.path,
    ca           = vault_mount.hah_pki_int.path
    role         = vault_pki_secret_backend_role.hah_int_role.name
  })
}
