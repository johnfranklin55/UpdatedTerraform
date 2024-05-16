terraform {
  backend "azurerm" {
    resource_group_name  = "john-franklin" 
    storage_account_name = "john55"        
    container_name       = "tfstate"       
    key                  = "prod.terraform.tfstate"    
  }
}