####What is it?

A [PoshCI](https://github.com/PoshCI/PoshCI) step that deploys a .nupkg to [Azure Websites](http://azure.microsoft.com/en-us/services/websites/).

####How do I install it?

```PowerShell
Add-CIStep -Name "YOUR-CISTEP-NAME" -PackageId "DeployNupkgToAzureWebsites"
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
![](https://ci.appveyor.com/api/projects/status/tgagt9cl2wr3f1os?svg=true)

