variable "organisation" {
  type        = string
  description = "Required. The Organisation deploying resources."
}

variable "environment" {
  type        = string
  description = "Required. The environment where this resource is deployed."
}

variable "workload" {
  type        = string
  description = "Required. The workload of this resource, of the type web or application."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the resource group is created. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "A map of tags to apply to the resources"
  default     = {}
}

variable "lock_level_value" {
  type        = string
  description = "The lock level for the resource group. Possible values are CanNotDelete, ReadOnly, or empty string to disable."
  default     = "CanNotDelete"
}

variable "notes" {
  type        = string
  description = "The notes for the lock"
  default     = "Resource Group is locked with CanNotDelete level"
}