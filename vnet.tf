#Create Virtual Networks 
resource "azurerm_virtual_network" "vnet-eus-dev" {
  name                = "vnet-eus-dev"
  location            = azurerm_resource_group.argocd-aks-eus-rg.location
  resource_group_name = azurerm_resource_group.argocd-aks-eus-rg.name
  address_space       = ["172.20.0.0/16"]

  # ###Service Principal Starts
   service_principal {
    client_id     = azuread_service_principal.sp.application_id
    client_secret = azuread_service_principal_password.sp.value
  }

  tags = {
    environment = "Development"
  }
}

#Create Aks Subnet
resource "azurerm_subnet" "aks-cluster-subnet" {
  name                 = "argocd-dev-eus-subn"
  resource_group_name  = azurerm_resource_group.argocd-aks-eus-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-eus-dev.name
  address_prefixes     = ["172.20.0.0/28"]
}
