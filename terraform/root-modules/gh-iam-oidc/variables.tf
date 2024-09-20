# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

variable "aws_region" {
  description = "The desired AWS region."
  type        = string
}

variable "namespace" {
  description = "The current namespace."
  type        = string
  default     = "measurabl"
}

variable "stage" {
  description = "The current stage or environment."
  type        = string
}

variable "gh_oidc_role_name" {
  description = "The name of the the github oidc role."
  type        = string
}

variable "domain" {
  description = "The domain that will use the github oidc role"
  type        = string
}

variable "repo_name" {
  description = "The Github repo name that can assume the github oidc role."
  type        = string
}

variable "user_name" {
  description = "The username for the person going through the tutorial"
  type        = string
}

variable "tf_state_bucket" {
  description = "the s3 bucket name for the tf state"
  type        = string
}

variable "tf_dynamo_db" {
  description = "the dynamodb table name for the tf state lock"
  type        = string
}
