targetScope = 'resourceGroup'

param midId string 
param resId string 
param rdId string 

resource newRA 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(resId, midId, rdId)
  properties: {
    roleDefinitionId: rdId
    principalId: midId
    principalType: 'ServicePrincipal'
  }
}

output newRA string = newRA.id
