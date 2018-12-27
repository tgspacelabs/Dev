$Filepath='C:\T ' # local directory to save build-scripts to
$DataSource='.' # server name and instance
$Database='portal' # the database to copy from

# set "Option Explicit" to catch subtle errors
set-psdebug -strict

$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs

# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")

if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9')
{
    [System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
}

$My = "$ms.Management.Smo";
$s = new-object ("$My.Server") $DataSource;
if ($s.Version -eq  $null )
{
    Throw "Can't find the instance $Datasource";
};

$db = $s.Databases[$Database];
if ($db.name -ne $Database)
{
    Throw "Can't find the database '$Database' in $Datasource"
};

$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $True # this only goes to the file
$transfer.Options.ExtendedProperties = $True;
$transfer.Options.Indexes = $True;
$transfer.Options.ToFileOnly = $True; # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database)_Build.sql";
$transfer.ScriptTransfer();

"All done";
