param vmName string
param adminUsername string
param adminPassword securestring
param vmSize string
param location string

var imagePublisher = 'MicrosoftWindowsDesktop'
var imageOffer = 'Windows-10'
var imageSku = '20h2-evd-o365pp'
var osDiskSizeGB = 80

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        diskSizeGB: osDiskSizeGB
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVmAgent: true
        enableAutomaticUpdates: true
      }
      secrets: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', '${vmName}-nic')
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: '${concat('https://', parameters('storageAccountName'), '.blob.core.windows.net')}'
      }
    }
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: '${vmName}-nic'
  location: location
  dependsOn: [
    vm
  ]
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
}
