## ------------------
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
## ------------------
## provider
## ------------------
provider "aws" {
  profile = "teraform"
  region  = "ap-northeast-1"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}
variable "aws_region" {
  type    = string
  default = "us-north-1"

}
