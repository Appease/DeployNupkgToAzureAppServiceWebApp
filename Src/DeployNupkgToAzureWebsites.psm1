# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Test-Uri
{
      <#
            .NOTES
                  Author: Will Steele
                  Last Modified Date: 07/27/2012
                 
            .EXAMPLE
                  Test-Uri -Uri 'http://www.msn.com'
                  True
           
            .EXAMPLE
                  Test-Uri -Uri 'http:/\hax0r.com'
                  False
      #>
     
      param(
            [ValidateNotNullOrEmpty()]
            [String]
            $Uri 
      )
     
      if([System.Uri]::IsWellFormedUriString($Uri, [System.UriKind]::RelativeOrAbsolute))
      {
            [System.Uri]::TryCreate($Uri, [System.UriKind]::RelativeOrAbsolute, [ref] $uri)
      }
      else
      {
            $false
      }
}

function Invoke-PoshDevOpsTask(

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebsiteName,

[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebsiteDeploymentPassword,

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

    $nugetExecutable = 'nuget'
    $nugetParameters = @('install',$NupkgId,'-Version',$NupkgVersion,'-Source',$NupkgSrc,'-OutputDirectory',$nupkgInstallDirPath)
Write-Debug `
@"
Invoking nuget:
& $nugetExecutable $($nugetParameters|Out-String)
"@
    & $nugetExecutable $nugetParameters
    # handle errors
    if ($LastExitCode -ne 0) {
        throw $Error
    }
    
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Deployment")
    
    $destBaseOptions = new-object Microsoft.Web.Deployment.DeploymentBaseOptions
    $destBaseOptions.UserName = "`$$WebsiteName"
    $destBaseOptions.Password = $WebsiteDeploymentPassword
    $destBaseOptions.ComputerName = "https://$WebsiteName.scm.azurewebsites.net/msdeploy.axd?site=$WebsiteName"
    $destBaseOptions.AuthenticationType = "Basic"

    $syncOptions = new-object Microsoft.Web.Deployment.DeploymentSyncOptions
    $syncOptions.WhatIf = $false
    $syncOptions.UseChecksum = $true

    $deploymentObject = [Microsoft.Web.Deployment.DeploymentManager]::CreateObject([Microsoft.Web.Deployment.DeploymentWellKnownProvider]::ContentPath, "$nupkgInstallDirPath\$NupkgId.$NupkgVersion")
    $deploymentObject.SyncTo([Microsoft.Web.Deployment.DeploymentWellKnownProvider]::ContentPath, $WebsiteName, $destBaseOptions, $syncOptions)

    # handle errors
    if ($LastExitCode -ne 0) {
        throw $Error
    }

}

Export-ModuleMember -Function Invoke-PoshDevOpsTask
