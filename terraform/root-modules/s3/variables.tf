variable "aws_region" {
  description = "The desired AWS region"
  type        = string
}

variable "aws_region_short" {
  description = "The shorted naming convention for the desired AWS region"
  type        = string
}

variable "namespace" {
  description = "The current namespace"
  type        = string
  default     = "measurabl"
}

variable "stage" {
  description = "The current stage or environment"
  type        = string
}

variable "domain" {
  description = "The domain that will use S3 bucket"
  type        = string
}

variable "bucket_name" {
  description = "the name for the S3 bucket (before namespace, staging, and domain are prepended)"
  type        = string
}

variable "user_name" {
  description = "The username for the person going through the tutorial"
  type        = string
}

variable "additional_tags" {
  description = "additional tags to add to the modules resources"
  type        = map(string)
  default     = {}
}
