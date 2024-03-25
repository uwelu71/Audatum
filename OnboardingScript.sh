
export subscriptionId="78e66c60-7927-4c38-a08e-d08dfe9a0048";
export resourceGroup="rg-arc-ch";
export tenantId="cf4c8625-ce49-44a3-94f9-9b27f46d8d8f";
export location="eastus";
export authType="token";
export correlationId="ffcf3185-aa69-4bd2-af3c-861720713d91";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter=CH01,City=Baar,StateOrDistrict=Zug,CountryOrRegion=Switzerland" --correlation-id "$correlationId";
