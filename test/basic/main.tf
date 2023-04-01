terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~> 3.9"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.0"
    }

  }
}

provider "azurerm" {

  features {

  }
}

resource "azurerm_resource_group" "test" {
  location = "westus"
  name     = "test-basic"
}

resource "random_integer" "suffix" {
  min = 1000
  max = 9999

  keepers = {
    randomness = azurerm_resource_group.test.name
  }
}

module "lens_base" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location


  datalake = {
    name                   = lower(format("%sdatalake%s", "lens", random_integer.suffix.result))
    tier                   = "Standard"
    replication_type       = "LRS"
    data_retention_in_days = 7
    containers             = ["metadata", "raw", "stage", "mdw"]

  }



  depends_on = [
    azurerm_resource_group.test
  ]
}



