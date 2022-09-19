export subscriptionId=3e2c8956-68de-4c31-aaff-a291a972f55e
export resourceGroup=rg-audatum-dc01-arc
export tenantId=67e5bfcc-79ed-407a-ac85-bea77b5ff470
export location=switzerlandnorth
export authType=token
export correlationId=b8d064cc-301e-4e36-86af-d2dc2708a003
export cloud=AzureCloud

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1)
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" https://gbl.his.arc.azure.com/log &> /dev/null || true; fi
echo "$output"

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter=DC01-SurfaceBook,City=ZRH-Airport,CountryOrRegion=Switzerland" --correlation-id "$correlationId"
