include "root" {
  path = find_in_parent_folders()
}

include "config" {
  path = "${get_terragrunt_dir()}/../../../../configs/gh-iam-oidc.hcl"
}
