Connect to Azure Account:
```
az login
```

List Azure Subscriptions:
```
az account list --output table
```

Create a Resource Group:
```
az group create --name MyResourceGroup --location westus
```

Create a Virtual Machine:
```
az vm create --resource-group MyResourceGroup --name MyVM --image Win2019Datacenter --admin-username admin --admin-password "P@ssw0rd" --location westus
```

Start a Virtual Machine:
```
az vm start --resource-group MyResourceGroup --name MyVM
```

Stop a Virtual Machine:
```
az vm stop --resource-group MyResourceGroup --name MyVM --no-wait --force
```

Deploy an Azure Resource Manager Template:
```
az deployment group create --resource-group MyResourceGroup --template-file /path/to/template.json --parameters @/path/to/parameters.json
```

List Azure Virtual Networks:
```
az network vnet list --output table
```

Create an Azure Storage Account:
```
az storage account create --resource-group MyResourceGroup --name mystorageaccount --location westus --sku Standard_LRS --kind StorageV2
```

Export Azure VMs to CSV:
```
az vm list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:location, PowerState:powerState}" --output csv > vmreport.csv
```
