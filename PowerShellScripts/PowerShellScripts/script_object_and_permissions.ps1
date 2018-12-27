# Powershell script to script out tables and procedures ( with dependencies) and permissions
# Pre-req: Install SQL 2012 management tools, Open Windows powershell and run this script

if($args.Count -le 1)
{
   throw "Usage: script_object_and_permissions.ps1 server_name, db_name"
}

$srvname = $args[0]
$database = $args[1]

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | out-null

$srv =  New-Object ("Microsoft.SqlServer.Management.SMO.Server") ($srvname)

$tableUrns = $srv.Databases[$database].Tables |  where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$viewUrns = $srv.Databases[$database].Views |  where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}
$sprocUrns = $srv.Databases[$database].StoredProcedures |  where-object { $_.IsSystemObject -eq $False } | foreach { $_.Urn}

$allUrns = @()
$allUrns = $allUrns + $tableUrns 
$allUrns = $allUrns + $sprocUrns

$scriptingOptions = New-Object ("Microsoft.SqlServer.Management.SMO.ScriptingOptions") 
$scriptingOptions.Permissions = $True                      # script permissions
$scriptingOptions.WithDependencies = $True                 # calculate dependencies before scripting

$scripter = New-Object ("Microsoft.SqlServer.Management.SMO.Scripter") ($srv)
$scripter.Options = $scriptingOptions;

write-host "Scripting " $allUrns.Length " objects ..."
foreach($s in $scripter.Script($allUrns))
{
    write-host $s
    write-host "GO"
}

