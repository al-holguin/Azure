# Connect to Azure using Azure PowerShell module
Connect-AzAccount

# Get all resources in the subscription
$resources = Get-AzResource

# Report resource details
foreach ($resource in $resources) {
    Write-Host "Resource Name: $($resource.Name)"
    Write-Host "Resource Type: $($resource.ResourceType)"
    Write-Host "Resource Location: $($resource.Location)"
    Write-Host "Resource Group: $($resource.ResourceGroupName)"
    Write-Host "-----"
}
