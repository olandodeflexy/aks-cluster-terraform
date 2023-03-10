resource "azuread_application" "sp" {
  display_name = local.sp_name
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.sp.application_id
}

resource "random_string" "unique" {
  length  = 32
  special = false
  upper   = true

  keepers = {
    service_principal = azuread_service_principal.sp.id
  }
}

resource "azuread_service_principal_password" "sp" {
  service_principal_id = azuread_service_principal.sp.id
  end_date = var.end_date
}


resource "azurerm_role_assignment" "role_assignment_aks" {
  scope                = azurerm_kubernetes_cluster.aks-cluster.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.id
}

resource "null_resource" "delay_after_sp_created" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  triggers = {
    "before" = azuread_service_principal_password.sp.value
  }
}