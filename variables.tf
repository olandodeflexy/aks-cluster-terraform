#Create Resource Group Location for AKS
variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

#Names of Services
variable "cluster_name" {
  default = "argocd-dev-eus-aks"
}

variable "end_date" {
  description = "The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. 2018-01-01T01:02:03Z)."
  type        = string
  default     = "2030-01-01T00:00:00Z"
}
# #Service Principal Starts
# variable "aks_service_principal_app_id" {
#   description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
# }

# variable "aks_service_principal_client_secret" {
#   description = "Secret of the service principal. Used by AKS to manage Azure."
# }

# variable "aks_service_principal_object_id" {
#   description = "Object ID of the service principal."
# }
# #Service Principal Ends

variable "service_cidr" {
  description = "(Optional) The Network Range used by the Kubernetes service.Changing this forces a new resource to be created."
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
  type        = string
  default     = "10.0.0.10"
}

variable "pod_cidr" {
  description = "(Optional) The CIDR to use for pod IP addresses. Changing this forces a new resource to be created."
  type        = string
  default     = "10.244.0.0/16"
}

variable "docker_bridge_cidr" {
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  type        = string
  default     = "172.17.0.1/16"
}

variable "prefix" {
  description = "(Required) Base name used by resources (cluster name, main service and others)."
  type        = string
}


#Node Count for each NodePool
variable "agent_count" {
  default = 1
}


variable "node_min_count" {
  description = "Minimum number of nodes in the cluster"
  default     = 1
}

variable "node_max_count" {
  description = "Maximum number of nodes in the cluster"
  default     = 4
}

variable "max_pods" {
  description = "Total number of pods that can be started on a kubernetes node  "
  default     = 110
}

#Declare DNS

variable "dns_prefix" {
  default = "aks-dns"
}