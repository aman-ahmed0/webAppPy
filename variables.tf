variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure Client ID (Service Principal)"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure Client Secret (Service Principal)"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH Public Key for VM Authentication"
  type        = string
}