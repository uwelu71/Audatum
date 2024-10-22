
export subscriptionId="c5365ae4-76ab-4929-907e-49d8456be106";
export resourceGroup="rg-wkl-dev-us_eastus-001";
export tenantId="e1a9f3b1-ad37-47e3-a4cb-8ab0c2d13f17";
export location="eastus";
export authType="token";
export correlationId="012fa435-feb4-41a5-9c4f-208afa649fd4";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O /tmp/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash /tmp/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
