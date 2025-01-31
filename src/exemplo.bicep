param serverName string = 'my-sql-server'
param adminUsername string = 'sqladmin'
param adminPassword string = 'P@ssw0rd1234'
param databaseName string = 'mydatabase'
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: '${sqlServer.name}/${databaseName}'
  location: location
  properties: {
    sku: {
      name: 'S0'
      tier: 'Standard'
      capacity: 10
    }
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  name: 'AllowAllIPs'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}
