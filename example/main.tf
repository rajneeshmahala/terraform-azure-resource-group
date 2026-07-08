provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

module "resourceGP" {
  source              = "../"
  organisation        = "opstree"
  environment         = "dev"
  workload            = "web"
  location            = "centralindia"
  resource_group_name = "myrgtest"
  tags = {
    Name = "AzureRG"
  }
}
