![](https://ci.appveyor.com/api/projects/status/1lowje6tsd7l5279?svg=true)

####What is it?

An [Appease](http://appease.io) task template that deploys a .nupkg to an [Azure app service web app](http://azure.microsoft.com/en-us/services/app-service/web/).

####How do I install it?

```PowerShell
Add-AppeaseTask `
    -DevOpName YOUR-DEVOP-NAME `
    -Name "YOUR-TASK-NAME" `
    -TemplateId "DeployNupkgToAzureAppServiceWebApp"
```

####What parameters are required?

#####WebAppName
description: a `string` representing the name of the web app being deployed to

#####WebAppDeploymentPassword
description: a `string` representing the deployment password of the web app being deployed to

#####NupkgId
description: a `string` representing the id of the .nupkg being deployed

#####NupkgVersion
description: a `string` representing the version of the .nupkg being deployed

#####NupkgSrc
description: a `string` representing the path to the src of the .nupkg being deployed