variable "datalake" {
  description = "Details of Storage Account DataLake to create. Note there are two access models: 'rbac' and 'sas'. RBAC is preferred, but requires the user or service principal who is running Terraform to be assigned at minimum 'Owner' role on the Resource Group where LENS is deployed (Subscription Owner role would work as well as it would be inherited by the Resource Group)."
  type = object({
    name                   = string
    tier                   = string
    replication_type       = string
    data_retention_in_days = number
    containers             = list(string)
    
   
   
  })
  default = {
    name                   = "lensdatalake"
    tier                   = "Standard"
    replication_type       = "LRS"
    data_retention_in_days = 7
    containers = [
      "metadata",
      "raw",
      "stage",
      "mdw"
    ]
 
    
  }

  
}


variable "resource_group_name" {
  description = "The name of the resource group where modules resources will be deployed. The resource group location will be used for all resources in this module as well."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}