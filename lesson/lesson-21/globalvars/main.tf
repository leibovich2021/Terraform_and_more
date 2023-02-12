provider "aws" {
  region = "ca-central-1"
}


terraform {
  backend "s3" {
    bucket = "denis-leibovich-project-terraform-network"
    key    = "globalvars/terraform.tfstate"
    region = "ca-central-1"
  }
}

#===================
output "company_name" {
  value = "ANDESA soft International"
}
output "owner" {
  value = "Denis Leibovich"
}

output "tags" {
  value = {
    Project    = "fanix2022"
    CostCenter = "R&D"
    Countr     = "Israel"
  }
}
