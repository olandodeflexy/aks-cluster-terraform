#!/bin/bash

login='source ~/.bash_profile'

# Define the Azure subscription id, resource group name, Key Vault name, and the service principle name
subscription_id="46081af3-7258-44cd-899c-db7516f0a121"
keyvault_name="argocd-tfs-kvault"
sp_name="master-vnet-infra-sp"
app_id="43d19897-998f-4b49-88ba-3919c3e74a04"

echo "logging into bash profile"
echo $login
# Get the device code
device_code=$(az login --use-device-code)

# Extract the device code URL and user code
device_code_url=$(echo $device_code | grep "http" | awk '{print $NF}')
user_code=$(echo $device_code | grep "user_code" | awk '{print $NF}')

# Inform the user to go to the device code URL and enter the user code
echo "Please go to the following URL and enter the user code: $device_code_url"
echo "User code: $user_code"

password=$(az keyvault secret show --name "$sp_name-secret" --vault-name "$keyvault_name" --query value --output tsv)


# Set the service principle credentials as environment variables
export ARM_CLIENT_ID="$app_id"
export ARM_CLIENT_SECRET="$password"

echo "service principle authenticated succesfully"