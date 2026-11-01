# Terraform CI/CD with Azure DevOps

## Overview

This project demonstrates how to deploy Azure infrastructure using Terraform and Azure DevOps CI/CD pipelines.

The infrastructure includes:
- Azure Resource Group
- Azure App Service Plan
- Azure Windows Web App
- Azure Blob Storage for remote Terraform state
- Separate Terraform state files for Dev and QA environments

---

## 1. Create Azure Storage for Terraform State

1. Create an Azure Resource Group for Terraform backend storage.
2. Create an Azure Storage Account.
3. Enable Blob Storage versioning to maintain previous versions of the state file.
4. Navigate to **Storage Account → Storage Browser → Blob Containers**.
5. Create a container named `statefile`.

This storage account will store Terraform state remotely.

---

## 2. Project Structure

Create a `Terraform` folder in your project:

```text
project/
└── Terraform/
    ├── providers.tf
    ├── backend-dev.conf
    ├── backend-qa.conf
    ├── variables.tf
    ├── dev.tfvars
    ├── qa.tfvars
    └── resource.tf
```

---

## 3. Configure Terraform Provider

### `providers.tf`

```hcl
terraform {
  required_version = ">= 1.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 5.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
```

---

## 4. Configure Remote Backend

### `backend-dev.conf`

```hcl
resource_group_name  = "terraformbackendrg"
storage_account_name = "growwtfstatesa"
container_name       = "statefile"
key                  = "dev.tfstate"
```

### `backend-qa.conf`

```hcl
resource_group_name  = "terraformbackendrg"
storage_account_name = "growwtfstatesa"
container_name       = "statefile"
key                  = "qa.tfstate"
```

Each environment uses a separate state file in the same Blob Storage container.

---

## 5. Define Terraform Variables

### `variables.tf`

```hcl
variable "rgname" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  type = string
}

variable "asp" {
  type = string
}

variable "webapp" {
  type = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}
```

---

## 6. Configure Environment Variables

### `dev.tfvars`

```hcl
environment = "dev"
rgname      = "grow-devrg"
asp         = "grow-dev-asp"
webapp      = "growwwebappdev001"
location    = "canadacentral"
```

### `qa.tfvars`

```hcl
environment = "qa"
rgname      = "grow-qarg"
asp         = "grow-qa-asp"
webapp      = "growwwebappqa001"
location    = "canadacentral"
```

---

## 7. Define Azure Resources

### `resource.tf`

```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_service_plan" "asp" {
  name                = var.asp
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "webapp" {
  name                = var.webapp
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = "v8.0"
    }
  }
}
```

---

## 8. Initialize and Validate Terraform

Run these commands from the `Terraform` directory.

### Initialize the QA backend

```bash
terraform init -reconfigure \
  -backend-config="backend-qa.conf"
```

### Validate the configuration

```bash
terraform validate
```

### Preview the QA deployment

```bash
terraform plan \
  -var-file="qa.tfvars"
```

### Apply the QA deployment

```bash
terraform apply \
  -var-file="qa.tfvars"
```

For Dev, replace the QA backend and variable files with their Dev equivalents:

```bash
terraform init -reconfigure \
  -backend-config="backend-dev.conf"

terraform plan \
  -var-file="dev.tfvars"
```

---

## 9. Create Azure DevOps Pipeline

1. Push the Terraform code to your Azure DevOps Git repository.
2. Open Azure DevOps and navigate to **Pipelines**.
3. Select **New Pipeline**.
4. Choose your repository.
5. Configure the pipeline to use an `azure-pipelines.yml` file.
6. Configure Azure service connection authentication and permissions for Terraform.
7. Run the pipeline to initialize Terraform, validate the configuration, and generate a plan.

### Recommended CI/CD workflow

```text
Developer
   |
   v
Push code to Azure Repos
   |
   v
Azure DevOps Pipeline
   |
   v
Terraform Init
   |
   v
Terraform Validate
   |
   v
Terraform Plan
   |
   v
Review and approve
   |
   v
Terraform Apply
   |
   v
Azure Resources Deployed
```

**Important:** Keep credentials out of Terraform files and Git. Use an Azure DevOps service connection or workload identity federation for authentication, and protect the production apply stage with approvals.
