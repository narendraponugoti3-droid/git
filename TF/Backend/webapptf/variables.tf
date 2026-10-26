
variable "rgname" {
  description = "Resource group name"
  type        = string
  default     = "webapprg"
}

variable "asp" {
  description = "App Service Plan name"
  type        = string
  default     = "credasp"
}

variable "webapp" {
  description = "Linux Web App name; must be globally unique"
  type        = string
  default     = "credprodwebapp"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}
