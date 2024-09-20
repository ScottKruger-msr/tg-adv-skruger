locals {
  env_vars         = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  namespace        = "measurabl"
  stage            = local.env_vars.locals.stage
  aws_region       = local.env_vars.locals.aws_region
  aws_region_short = local.aws_region_short_names[local.aws_region]
  tf_state_bucket  = "${local.namespace}-${local.stage}-${local.aws_region_short}-tf-${local.domain}-${local.repo_name}"
  tf_dynamo_db     = "${local.namespace}-${local.stage}-${local.aws_region_short}-tf-lock-${local.domain}-${local.repo_name}"
  repo_name        = "tg-adv-${local.user_name}"

  # Add regions and their short name as necessary.
  # Some good patterns are mentioned here https://gist.github.com/colinvh/14e4b7fb6b66c29f79d3
  aws_region_short_names = {
    us-east-1 = "use1"
    us-east-2 = "use2"
    us-west-1 = "usw1"
    us-west-2 = "usw2"
  }

  #####################
  # TODO: Update these
  #####################
  user_name = "skruger"
  domain    = "unified-experience"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }
}

provider "aws" {
  region = "${local.aws_region}"
  default_tags {
    tags = {
      Environment    = "${local.stage}"
      Provisioned-By = "Terraform"
      Root-Module    = "${basename(path_relative_to_include())}"
      Domain = "${local.domain}"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.tf_state_bucket}"
    key            = "${basename(path_relative_to_include())}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "${local.tf_dynamo_db}"
    s3_bucket_tags = {
      Domain = "${local.domain}"
    }
    dynamodb_table_tags = {
      Domain = "${local.domain}"
    }
  }
}

inputs = {
  namespace         = local.namespace
  stage             = local.stage
  aws_region        = local.aws_region
  repo_name         = local.repo_name
  user_name         = local.user_name
  domain            = local.domain
  aws_region_short  = local.aws_region_short_names
  tf_dynamo_db      = local.tf_dynamo_db
  tf_state_bucket   = local.tf_state_bucket
  gh_oidc_role_name = "${local.repo_name}-${local.stage}-gh-oidc"
}
