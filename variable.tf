variable "azurerm_service_plan" {
  type = string
  default = "MyAppPlan"
  description = "name of the service plan"
  
}

variable "azurerm_windows_web_app" {
  type = string
  default = "jayFapp"
  description = "name of the web app"
  
}

variable "azurerm_virtual_network" {
  type = string
  default = "john-franklin-vnet"
  description = "name of the vnet"
  
}

variable "address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
  description = "address space for the vnet"
}

variable "azurerm_subnet" {
  type = string
  default = "subnetA"
  description = "name of the subnet"
}

variable "address_prefixes" {
  type = list(string)
  default = ["10.0.0.0/20"]
  description = "address prefix for the subnet"
  
}
variable "azurerm_network_interface" {
  type = string
  default = "john-franklin-nic"
  description = "virtual nework"
    
}

variable "azurerm_windows_virtual_machine" {
  type = string
  default = "john-franklinVM"
  description = "virtual machine name"
}

variable "admin_username" {
  type = string
  description = "user name of the virtual machine"
}

variable "admin_password" {
  type = string
  description = "user name password for the virtual machine"
}

