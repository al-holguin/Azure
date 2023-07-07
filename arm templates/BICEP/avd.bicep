param vmPrefix string
param adminUsername string
param adminPassword securestring
param vmSize string
param location string
param sqlServerName string
param sqlAdminUsername string
param sqlAdminPassword securestring
param sqlDatabaseName string
param sqlDatabaseEdition string = 'Basic'
param sqlDatabaseSize string = '2GB'

var osDiskSizeGB = 100
var sqlServerVersion = '12.0'

resource vms 'Microsoft.Compute/virtualMachines@2021-07-01' = [for i in range(0, 10): {
  name: '${vmPrefix}${i}'
  location: location
  dependsOn: [
    '${sqlServerName}'
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        diskSizeGB: osDiskSizeGB
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
    }
    osProfile: {
      computerName: '${vmPrefix}${i}'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVmAgent: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', '${vmPrefix}${i}-nic')
        }
      ]
    }
  }
}]

resource sqlServer 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
    version: sqlServerVersion
    publicNetworkAccess: 'Enabled'
  }
  resources: [
    {
      type: 'databases'
      apiVersion: '2020-02-02-preview'
      name: sqlDatabaseName
      dependsOn: [
        sqlServer
      ]
      properties: {
        collation: 'SQL_Latin1_General_CP1_CI_AS'
        edition: sqlDatabaseEdition
        maxSizeBytes: 1073741824
        requestedServiceObjectiveName: sqlDatabaseSize
      }
    }
  ]
}

resource nics 'Microsoft.Network/networkInterfaces@2021-02-01' = [for i in range(0, 10): {
  name: '${vmPrefix}${i}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'your-vnet-name', 'your-subnet-name')
          }
        }
      }
    ]
  }
}]

output vmNames array = [for vm in vms: vm.name]

