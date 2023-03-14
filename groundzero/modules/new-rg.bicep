targetScope = 'subscription'

param rgName string 
param rgLocation string 
param resTags object

resource newRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: rgLocation
  tags: resTags
}

output rgId string = newRg.id
