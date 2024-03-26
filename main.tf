terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }
  }
}

provider "azuread" {
  # Configuration options
  # Tenant M365x13773766
  # admin@M365x13773766.onmicrosoft.com
}

data "azuread_client_config" "current" {}

resource "azuread_group" "ca_exclude" {
  display_name     = "ca_exclude"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
