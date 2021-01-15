variable "resource_group" {
  type    = string
  default = "rg-terraform"
}

variable "webapp_name" {
  type    = string
  default = "terraform"
}

variable "location" {
  type    = string
  default = "japaneast"
}

variable "runtime_stack" {
  type    = string
  default = "NODE|12-lts"
}

variable "functions_worker_runtime" {
  type    = string
  default = "node"
}

#variable "azure_client_id" {
#  type = string
#}
#
#variable "azure_client_secret" {
#  type = string
#}
