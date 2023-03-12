# Add the service principal application ID and secret here
servicePrincipalClientId="169f8568-c338-4851-b2e7-866d953d1a66";
servicePrincipalSecret="Av~8Q~JhQeAMw~x6yTr4o9yMvHLphuIgqxhOeagF";


export subscriptionId="3e2c8956-68de-4c31-aaff-a291a972f55e";
export resourceGroup="rg-audat-mspdc01";
export tenantId="67e5bfcc-79ed-407a-ac85-bea77b5ff470";
export location="switzerlandnorth";
export authType="principal";
export correlationId="e35a00fc-14b3-4fd9-a177-f313b36e2100";
export cloud="AzureCloud";

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter=mspDC01,City=Gottmadingen,CountryOrRegion=Germany" --correlation-id "$correlationId";
