targetScope = 'resourceGroup'

param nsgName string 
param nsgLocation string = resourceGroup().location
param resTags object


resource newNSG 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName
  location: nsgLocation
  tags: resTags
  properties: {}
}

//deploy NSG rules
//module inRuleMDL 'set-in-rules.bicep' = {
//  name: 'in-rules-deploy'
//  dependsOn: [
//    newNSG
//  ]
//  params: { 
//    nsgName: nsgName
//  }
//}

//module outRuleMDL 'set-out-rules.bicep' = {
//  name: 'out-rules-deploy'
//  dependsOn: [
//    newNSG
//  ]
//  params: { 
//    nsgName: nsgName
//  }
//}

output nsgId string = newNSG.id
