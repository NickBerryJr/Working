targetScope = 'resourceGroup'

param peName string 
param snId string
param kvId string
param resTags object
param peLocation string = resourceGroup().location

resource newPE 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: peName
  location: peLocation
  tags: resTags
  properties: {
    subnet: {
      id: snId
    }
    privateLinkServiceConnections: [
      {
        name: peName
        properties: {
          privateLinkServiceId: kvId
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}

output peId string = newPE.id
