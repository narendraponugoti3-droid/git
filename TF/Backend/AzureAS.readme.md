### terraform backend and CICD  

Interview Importent 

every time terraform state file should moved to S3 backend 
terraform backend is place where TF stores and manages the state --> local laptop ,AWS S3, Azure AS
terraform.tfstate
<img width="1113" height="472" alt="image" src="https://github.com/user-attachments/assets/13afc49d-465e-44f2-a3cf-8bfa59a66293" />
<img width="931" height="162" alt="image" src="https://github.com/user-attachments/assets/672ce121-aef0-42f7-b5fb-274c740ee054" />
<img width="1063" height="336" alt="image" src="https://github.com/user-attachments/assets/6ff2266f-1490-4a07-96c5-7923ee6e0775" />

Step1:
Create Backned Azure SA with enable version for blobs 
Security -->Allow enabling anonymous access on individual containers 
Then Create the Azure SA 
Then Create the container 
Data Storage --> Containers 

Container : backend
saname: credtfstatebackend
rgname: TFStateRG



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

variables.tf
==========
variable "rgname"{
 description ="resoruce group name"
 type=string 
 default="webapprg"
}
variable "asp"{
 description ="ASP Name"
 type=string 
 default="credasp"
}
variable "webapp"{
 description ="webapp Name"
 type=string 
 default="credprodwebapp"
}
variable "location"{
 description ="Location"
 type=string 
 default="canadacentra1"
}

resoruces.tf 
resource "azurerm_resource_group" "credrg" {
  name     = var.rgname
  location = var.location
}

resoruces.tf 
------------
resource "azurerm_resource_group" "credrg" {

name = var.rgname 
location=var.location
}
resource "azurerm_service_plan" "credasp"
{
name=var.asp
resource_group_name=azurerm_resource_group.credrg.name
location=azurerm_resource_group.credrg.location
os_type="Linux"
sku_name="B1"
}

resource "azurerm_linux_web_app" "credwebapp" {
  name                = var.webapp
  resource_group_name = azurerm_resource_group.credrg.name
  location            = azurerm_resource_group.credrg.location
  service_plan_id     = azurerm_service_plan.credasp.id

  site_config {
    always_on = false

    application_stack {
      node_version = "22-lts"
    }
