
# Create (and display) an SSH key
resource "tls_private_key" "aksvmshkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azurerm_subnet" "aks-cluster-subnet" {
  name                 = "argocd-dev-eus-subn"
  virtual_network_name = azurerm_virtual_network.vnet-eus-dev.name
  resource_group_name  = azurerm_resource_group.argocd-aks-eus-rg.name
  depends_on           = [azurerm_virtual_network.vnet-eus-dev]
}
####Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks-cluster" {

  depends_on = [
    null_resource.delay_after_sp_created
  ]

  name                = var.cluster_name
  location            = azurerm_resource_group.argocd-aks-eus-rg.location
  resource_group_name = azurerm_resource_group.argocd-aks-eus-rg.name
  dns_prefix          = var.dns_prefix

  ####Create AKS Cluster Master [System] Node
  default_node_pool {
    name       = "master"
    vm_size    = "standard_a2_v2" #Specify Good Compute Size for Cluster Master
    enable_auto_scaling   = true
    os_disk_size_gb       = 30               # decide on disk sizes later.
    node_count            = var.agent_count  # set it to 2 for production
    min_count             = var.agent_count
    max_count             = var.node_max_count
    orchestrator_version  = "1.23.8"
    os_sku                = "Ubuntu"
  }
  
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = tls_private_key.aksvmshkey.public_key_openssh

    }
  }

  # ###Service Principal Starts
   service_principal {
    client_id     = azuread_service_principal.sp.application_id
    client_secret = azuread_service_principal_password.sp.value
  }

  #Enable Azure Policy
  azure_policy_enabled = true

  #CNI
  network_profile {
    network_plugin     = "kubenet"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    pod_cidr           = var.pod_cidr
    docker_bridge_cidr = var.docker_bridge_cidr
  }


  tags = {
    Environment = "Development"
  }
  ###Service Principal Ends

}
##End of Node Pool Creation

