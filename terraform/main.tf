terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.20.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_app_service_plan" "example" {
  name                = "${var.webapp_name}-asp"
  location            = var.location
  resource_group_name = var.resource_group
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "PremiumV2"
    size = "P1v2"
    # number of instances
    capacity = 2
  }

}

resource "azurerm_app_service" "example" {
  name                = var.webapp_name
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 0
        retention_in_mb   = 35
      }

    }
  }


  # auth_settings {
  #   enabled                       = true
  #   default_provider              = "AzureActiveDirectory"
  #   unauthenticated_client_action = "RedirectToLoginPage"
  #   active_directory {
  #     client_id     = var.azure_client_id
  #     client_secret = var.azure_client_secret
  #   }
  # }

  site_config {
    always_on        = true
    linux_fx_version = var.runtime_stack
    # https://docs.microsoft.com/ja-jp/azure/app-service/configure-language-python
    # app_command_line = "gunicorn --bind=0.0.0.0 --timeout 600 --chdir app main:app"
    app_command_line = ""
    ftps_state       = "Disabled"
  }

}

# Add Staging slot
resource "azurerm_app_service_slot" "example" {
  name                = "staging"
  app_service_name    = azurerm_app_service.example.name
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.example.id

}