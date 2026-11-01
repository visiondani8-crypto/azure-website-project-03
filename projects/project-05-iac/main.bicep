targetScope = 'resourceGroup'

@description('Azure deployment region')
param location string = 'centralus'

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'nsg-p05-workloads'
  location: location
  properties: {
    securityRules: [
      {
        name: 'DenyInternetOutbound'
        properties: {
          description: 'Deny outbound Internet traffic'
          priority: 200
          direction: 'Outbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'Internet'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-p05-lab'
  location: location
  properties: {
    privateEndpointVNetPolicies: 'Disabled'
    addressSpace: {
      addressPrefixes: [
        '10.50.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'snet-workloads'
  properties: {
    privateEndpointNetworkPolicies: 'Disabled'
    addressPrefix: '10.50.1.0/24'
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

output virtualNetworkName string = vnet.name
output subnetName string = subnet.name
output networkSecurityGroupName string = nsg.name
