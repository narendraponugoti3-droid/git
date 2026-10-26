terraform{
 required_version= ">=1.12"
 required_providers {
 azurerm={
   soruce="hashicorp/azurerm"
   version=">=5.0"
   }
  }
backend " azurerm"{
  resoruce_group_name="" ;
  storage_account_name="" 
  container_name=""
  key =""
  }
}
provider "azurerm"{
features{}
}
