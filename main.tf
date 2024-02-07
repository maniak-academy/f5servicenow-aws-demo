terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
    bigip = {
      source = "F5Networks/bigip"
      version = "1.20.2"
    }
  }
    cloud {
    organization = "maniakacademy"

    workspaces {
      project = "f5-demo-env"
      tags = ["networking", "source:cli"]
    }
  }
  

  required_version = ">=1.5.0"

}


provider "bigip" {
  address  = "${module.bigip[0].mgmtPublicIP}:8443"
  username = "bigipuser"
  password = random_string.password.result
}
provider "aws" {
  region = "us-east-1"
}


