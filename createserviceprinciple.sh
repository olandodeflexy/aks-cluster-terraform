#!/bin/bash

# Define the Azure subscription id, resource group name, Key Vault name, and the service principle name
subscription_id="46081af3-7258-44cd-899c-db7516f0a121"
keyvault_name="argocd-tfs-kvault"
sp_name="master-vnet-infra-sp"

# Get the device code
device_code=$(az login --device-code)

# Extract the device code URL and user code
device_code_url=$(echo $device_code | grep "http" | awk '{print $NF}')
user_code=$(echo $device_code | grep "user_code" | awk '{print $NF}')

# Inform the user to go to the device code URL and enter the user code
echo "Please go to the following URL and enter the user code: $device_code_url"
echo "User code: $user_code"

# Wait for the user to log in
az login --use-device-code

# Set the Azure subscription
az account set --subscription "$subscription_id"

# Create the service principle
sp=$(az ad sp create-for-rbac --name "$sp_name")

# Extract the appId and password from the service principle
app_id=$(echo "$sp" | jq -r .appId)
password=$(echo "$sp" | jq -r .password)

# Store the service principle secret in Azure Key Vault
az keyvault secret set --vault-name "$keyvault_name" --name "$sp_name-secret" --value "$password"

# Display the service principle app id
echo "Service principle app id: $app_id"

echo "service principle $sp_name created successfully"
