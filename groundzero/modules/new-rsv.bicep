targetScope = 'resourceGroup'

param rsvName string 
param resTags object
param rsvLocation string = resourceGroup().location
param midName string 
param currentTime string = utcNow()
param keyId string 
//param subId string 

var midId = '${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${midName}'

resource newRSV 'Microsoft.RecoveryServices/vaults@2022-01-01' = {
  name: rsvName
  location: rsvLocation
  tags: resTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${midId}':{}
    }
  }
  properties:{}
}

resource runCLI 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runCLI'
  location: rsvLocation
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/0c59ce02-f37e-49e5-8128-90bffc9ceee1/resourceGroups/rg-afk-templateSpecs/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mid-iac-uami-01': {}
    }
  }
  properties:{
    azCliVersion: '2.33.1'
    timeout: 'PT10M'
    retentionInterval: 'P1D'
    cleanupPreference: 'OnSuccess'
    forceUpdateTag: currentTime // ensures script will run every time    
    scriptContent: 'az backup vault encryption update --encryption-key-id ${keyId} --mi-user-assigned ${midId} --resource-group ${resourceGroup().name} --name ${rsvName}'
  }
  dependsOn: [
    newRSV
  ]
}

output rsvId string = newRSV.id
output sysId string = newRSV.identity.type
