# Powershell script to script out tables and procedures ( with dependencies) and permissions
# Pre-req: Install SQL 2012 management tools, Open Windows powershell and run this script

#if($args.Count -le 1)
#{
#   throw "Usage: script_object_and_permissions.ps1 server_name, db_name"
#}

#$srvname = $args[0]
#$database = $args[1]

$FilePath = 'C:\T'; # local directory to save build-scripts to
$srvname = ".";
$Database = 'Portal'; # the database to copy from
$ScriptFilename = "$($FilePath)\$($Database)X-Build.sql";

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | out-null

$srv = New-Object ("Microsoft.SqlServer.Management.SMO.Server") ($srvname)

$tableUrns = $srv.Databases[$database].Tables | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$indexUrns = $srv.Databases[$database].i | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$triggerUrns = $srv.Databases[$database].Triggers | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$viewUrns = $srv.Databases[$database].Views | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$sprocUrns = $srv.Databases[$database].StoredProcedures | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$functionUrns = $srv.Databases[$database].UserDefinedFunctions | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$userDataTypesUrns = $srv.Databases[$database].UserDefinedDataTypes | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$userTableTypesUrns = $srv.Databases[$database].UserDefinedTableTypes | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$userTypesUrns = $srv.Databases[$database].UserDefinedTypes | where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}

$allUrns = @()
$allUrns += $tableUrns
$allUrns += $indexUrns
$allUrns += $triggerUrns
$allUrns += $viewUrns
$allUrns += $sprocUrns
$allUrns += $functionUrns
$allUrns += $userDataTypesUrns
$allUrns += $userTableTypesUrns;
$allUrns += $userTypesUrns

$scriptingOptions = New-Object ("Microsoft.SqlServer.Management.SMO.ScriptingOptions") 
$scriptingOptions.AllowSystemObjects = $False;
$scriptingOptions.AppendToFile = $False;
$scriptingOptions.DriAll = $True;
$scriptingOptions.ExtendedProperties = $True;
$scriptingOptions.FileName = $ScriptFilename;
$scriptingOptions.IncludeHeaders = $True;
$scriptingOptions.Indexes = $True;                # script all indexes
$scriptingOptions.NonClusteredIndexes = $True;
$scriptingOptions.Permissions = $True;            # script permissions
$scriptingOptions.ScriptDrops = $False;
$scriptingOptions.ToFileOnly = $True;
$scriptingOptions.Triggers = $True;
$scriptingOptions.WithDependencies = $True;       # calculate dependencies before scripting

$scripter = New-Object ("Microsoft.SqlServer.Management.SMO.Scripter") ($srv)
$scripter.Options = $scriptingOptions;

<#Script the Drop too#>
#$ScriptDrop = new-object ('Microsoft.SqlServer.Management.Smo.Scripter') ($SMOserver)
#$ScriptDrop.Options.AppendToFile = $True
#$ScriptDrop.Options.AllowSystemObjects = $False
#$ScriptDrop.Options.ClusteredIndexes = $True
#$ScriptDrop.Options.DriAll = $True
#$ScriptDrop.Options.ScriptDrops = $True
#$ScriptDrop.Options.IncludeHeaders = $True
#$ScriptDrop.Options.ToFileOnly = $True
#$ScriptDrop.Options.Indexes = $True
#$ScriptDrop.Options.WithDependencies = $False

Clear-Host;

Write-Host "/**************************************************************************************************";
Write-Host "--- SQL Server Information ---";
Write-Host $srv;
Write-Host $srv.Properties;
Write-Host $srv.Settings.Properties;
Write-Host "**************************************************************************************************/";

Write-Host;
Write-Host "/**************************************************************************************************";
Write-Host "--- ""Portal"" Database Information ---";
Write-Host $srv.Databases[$database].Properties;
Write-Host $srv.Databases[$database].DatabaseOptions;
Write-Host "**************************************************************************************************/";

Write-Host;
Write-Host "/**************************************************************************************************";
Write-Host "--- Scripting " $allUrns.Length " objects ---";
Write-Host "**************************************************************************************************/";

foreach($s in $scripter.Script($allUrns))
{
    Write-Host $s;
    Write-Host "GO";
}
