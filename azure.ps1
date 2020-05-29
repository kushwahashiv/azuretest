

$SUBSCRIPTION_ID='d280dfac-1581-4b1c-9d9d-cecead479745'
$SERVICE_PRINCIPAL_NAME='PythonTestApp'
$RES_GROUP='azuretest' # Resource Group name
$ACR_NAME='azuretestContainerRegistry007' 
#$AKV_NAME='CR007keyvault'

az login

# Get the resource ID of the recource group
$groupId=$(az group show --name $RES_GROUP --query id --output tsv)

# Create service principal for the recource group
az ad sp create-for-rbac --scope $groupId --role Owner --sdk-auth

# Create container registry
az acr create --resource-group $RES_GROUP --name $ACR_NAME  --sku Basic

# Get the resource id of the container regostry
$registryId=$(az acr show --name $ACR_NAME --query id --output tsv)

#Update service principal for registry authentication
az role assignment create --assignee "8ad597fc-feb6-40ae-add3-9f766e96b3f3" --scope $registryId --role Owner
