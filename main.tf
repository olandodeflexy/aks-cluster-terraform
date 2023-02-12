
#Create Resource Group for AKS Cluster
resource "azurerm_resource_group" "argocd-aks-eus-rg" {
  name     = "argocd-dev-eus-rg"
  location = var.resource_group_location

}