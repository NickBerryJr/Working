targetScope = 'resourceGroup'

param kvName string 
param resTags object
param kvLocation string = resourceGroup().location
param keyName string

resource newKV 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: kvName
  location: kvLocation
  tags: resTags
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    enableRbacAuthorization: true
    enableSoftDelete: true
    enablePurgeProtection: true
    softDeleteRetentionInDays: 90
    
    publicNetworkAccess: 'disabled'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  
  }
}

resource newKey 'Microsoft.KeyVault/vaults/keys@2021-10-01' = {
  name: keyName
  parent: newKV
  //tags: resTags
  properties:{
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'wrapKey'
      'unwrapKey'
    ]
    keySize: 2048
    curveName: 'P-256'
  }
}

output kvId string = newKV.id
output keyId string = newKey.properties.keyUri
