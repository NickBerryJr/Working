targetScope = 'resourceGroup'

param midName string 
param midLocation string = resourceGroup().location
param resTags object


resource newMid 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: midName
  location: midLocation
  tags: resTags
}

output midId string = newMid.properties.principalId
