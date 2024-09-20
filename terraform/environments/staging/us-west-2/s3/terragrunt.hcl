include "root" {
  path = find_in_parent_folders()
}

include "config" {
  path = "${get_terragrunt_dir()}/../../../../configs/s3.hcl"
}

inputs = {
  # TODO: Update this
  bucket_name = "<INSERT_BUCKET_NAME>"
}
