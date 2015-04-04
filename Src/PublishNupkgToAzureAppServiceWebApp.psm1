# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Invoke(

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebAppName,

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebAppDeploymentPassword,

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgId,

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgVersion,

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgSrc){

    if(Test-Path $NupkgSrc){
        $NupkgSrc = Resolve-Path $NupkgSrc
        Write-Debug "Resolved `$NupkgSrc to folder: $NupkgSrc"
    }

    $nupkgInstallDirPath = "$PSScriptRoot\Packages"

    $NuGetCommand = 'nuget'
    $NuGetParameters = @('install',$NupkgId,'-Version',$NupkgVersion,'-Source',"$NupkgSrc",'-OutputDirectory',$nupkgInstallDirPath)
Write-Debug `
@"
Invoking nuget:
& $NuGetCommand $($NuGetParameters|Out-String)
"@
    & $NuGetCommand $NuGetParameters
    # handle errors
    if ($LastExitCode -ne 0) {
        throw $Error
    }
    
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Deployment")
    
    $destBaseOptions = new-object Microsoft.Web.Deployment.DeploymentBaseOptions
    $destBaseOptions.UserName = "`$$WebAppName"
    $destBaseOptions.Password = $WebAppDeploymentPassword
    $destBaseOptions.ComputerName = "https://$WebAppName.scm.azurewebsites.net/msdeploy.axd?site=$WebAppName"
    $destBaseOptions.AuthenticationType = "Basic"

    $syncOptions = new-object Microsoft.Web.Deployment.DeploymentSyncOptions
    $syncOptions.WhatIf = $false
    $syncOptions.UseChecksum = $true

    $deploymentObject = [Microsoft.Web.Deployment.DeploymentManager]::CreateObject([Microsoft.Web.Deployment.DeploymentWellKnownProvider]::ContentPath, "$nupkgInstallDirPath\$NupkgId.$NupkgVersion")
    $deploymentObject.SyncTo([Microsoft.Web.Deployment.DeploymentWellKnownProvider]::ContentPath, $WebAppName, $destBaseOptions, $syncOptions)

    # handle errors
    if ($LastExitCode -ne 0) {
        throw $Error
    }

}

Export-ModuleMember -Function Invoke
