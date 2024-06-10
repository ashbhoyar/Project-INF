terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

provider "aws" {
  access_key ="xxx"
  secret_key ="xxxx"
  region ="xxx"
}