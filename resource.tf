locals {

  prefix    = var.prefix
  sp_name   = "${var.prefix}-sp"
  location  = var.resource_group_location
}

resource "local_file" "kubeconfig_file" {
  content  = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  filename = "${azurerm_kubernetes_cluster.aks-cluster.name}_config"
}