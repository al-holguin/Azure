Top 10 Azure PowerShell scripts

Connect to Azure Account:
```
Connect-AzAccount
```

List Azure Subscriptions:
```
Get-AzSubscription
```

Create a Resource Group:
```
New-AzResourceGroup -Name "MyResourceGroup" -Location "WestUS"
```

Create a Virtual Machine:
```
New-AzVm -ResourceGroupName "MyResourceGroup" -Name "MyVM" -Location "WestUS" -ImageName "Win2019Datacenter" -AdminUsername "admin" -AdminPassword "P@ssw0rd"
```

Start a Virtual Machine:
```
Start-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
```

Stop a Virtual Machine:
```
Stop-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM" -Force
```

Deploy an Azure Resource Manager Template:
```
New-AzResourceGroupDeployment -ResourceGroupName "MyResourceGroup" -TemplateFile "C:\Templates\template.json" -TemplateParameterFile "C:\Templates\parameters.json"
```

List Azure Virtual Networks:
```
Get-AzVirtualNetwork
```

Create an Azure Storage Account:
```
New-AzStorageAccount -ResourceGroupName "MyResourceGroup" -Name "mystorageaccount" -Location "WestUS" -SkuName "Standard_LRS" -Kind "StorageV2"
```

Export Azure VMs to CSV:
```
Get-AzVM | Select-Object Name, ResourceGroupName, Location, PowerState | Export-Csv -Path "C:\Reports\vmreport.csv" -NoTypeInformation
```
