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