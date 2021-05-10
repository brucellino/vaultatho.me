data "local_file" "read_only_policy" {
  filename = "${path.module}/policies/read-only.hcl"
}

resource "vault_policy" "read_only" {
  name   = "read-only"
  policy = data.local_file.read_only_policy.content
}
