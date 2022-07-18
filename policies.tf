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
  name   = "consul"
  policy = file("${path.module}/policies/consul.hcl")
}
