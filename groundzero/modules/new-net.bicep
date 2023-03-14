targetScope = 'resourceGroup'

param vnName string 
param vnPrefix string 
param snName string 
param snPrefix string 
param resTags object
param vnLocation string = resourceGroup().location



resource newVnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnName
  location: vnLocation
  tags: resTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnPrefix
      ]
    }
    dhcpOptions:{
      dnsServers: [
       '1.1.0.4' 
    
  ]
    }
    subnets: [
      {
        name: snName
        properties: {
          addressPrefix: snPrefix
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}

output vnId string = newVnet.id
output snId string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnName, snName)
