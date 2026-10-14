// infra/cosmos-role.bicep
targetScope = 'resourceGroup' // Sets validation cleanly to the Resource Group layer

param cosmosAccountResourceId string
param principalId string

// Parse the raw account name ('nino-cosmosdb') cleanly from its resource ID path string
var cleanAccountName = last(split(cosmosAccountResourceId, '/'))

// Deploy the SQL role assignment using its fully-qualified path structure
resource cosmosDataRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2023-11-15' = {
  name: '${cleanAccountName}/${guid(cosmosAccountResourceId, principalId, 'cosmos-data-contributor')}'
  properties: {
    // Generate the exact built-in SQL Data Contributor path dynamically from your resource ID
    roleDefinitionId: '${cosmosAccountResourceId}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002'
    principalId: principalId
    scope: cosmosAccountResourceId
  }
}

