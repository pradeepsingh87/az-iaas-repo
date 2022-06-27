# 0 : Log into azure . Check the list of accounts you have configured in local . Get the subscription id from portal .Set a particular subscription.
az login
az account list
az account set --subscription subscriptionid

# 1 : Create a resource group 
az group create \
  --name "psb-rg" \
  --location "eastus"
  
# 2 : Create a virtual machine . admin-password is a mandatoty feild . If not passed you will be prompted to enter it .Full command : https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-create
az vm create \
  --resource-group "psb-rg" \
  --name "psb-win-cli" \
  --image "win2019datacenter" \
  --admin-username "psb-admin" 

az vm create \
  --resource-group "psb-rg" \
  --name "psb-linux-cli" \
  --image "UbuntuLTS" \
  --admin-username "psb-admin" \
  --authentication-type "ssh" \
  --ssh-key-value ~/.ssh/id_rsa.pub
  

# 3 : Ensure Remote Access Port is Open . 3389 for Windows . 22 for Linux . 
az vm open-port \
  --resource-group "psb-rg" \
  --name "psb-win-cli" \
  --port "3389"
  
az vm open-port \
  --resource-group "psb-rg" \
  --name "psb-linux-cli" \
  --port "22"
  
# 4 : Retrive the Public IP address.commadn number 2 will also give you the public ip in console . 
#     But use below command it you want it explicitly. 

az vm list-ip-addresses \
  --resource-group "psb-rg" \
  --name "psb-win-cli" \
  --output table
  
az vm list-ip-addresses \
  --resource-group "psb-rg" \
  --name "psb-linux-cli" \
  --output table
  
# 5 : Optional . Set an auto shut down schedule for vm . 
az vm auto-shutdown \
  -g psb-rg \
  -n "psb-win-cli" \
  --time 0230 --email "itspradeep.singh@outlook.com" 
  
az vm stop \
  --name "psb-linux-cli" \
  --resource-group "psb-rg"  \
  --output table 
  

# 6 : Optional . Clean up the resource in this demo.   
az group delete --name "psb-rg" 
