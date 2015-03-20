####What is it?

A [PoshDevOps](https://github.com/PoshDevOps/PoshDevOps) task that deploys a .nupkg to [Azure Websites](http://azure.microsoft.com/en-us/services/websites/).

####How do I install it?

```PowerShell
Add-PoshDevOpsTask -Name "YOUR-TASK-NAME" -PackageId "DeployNupkgToAzureWebsites"
```

####What parameters are available?

#####WebsiteName
A String representing the name of the website being deployed to
```PowerShell
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebsiteName
```

#####WebsiteDeploymentPassword
A String representing the deployment password of the website being deployed to
```PowerShell
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$WebsiteDeploymentPassword
```

#####NupkgId
A String representing the id of the .nupkg being deployed
```PowerShell
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgId
```

#####NupkgVersion
A String representing the version of the .nupkg being deployed
```PowerShell
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgVersion
```

#####NupkgSrc
A String representing the path to the src of the .nupkg being deployed
```PowerShell
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$NupkgSrc
```

####What's the build status?
![](https://ci.appveyor.com/api/projects/status/1lowje6tsd7l5279?svg=true)

