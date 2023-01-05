# PowerShell RAR Module

## Install

```powershell
$MOD = "RAR"; $DIR = "$( (${ENV:PSModulePath} -split ';')[0] )"; Invoke-WebRequest "https://github.com/pkgstore/pwsh-$( ${MOD}.ToLower() )/archive/refs/heads/main.zip" -OutFile "${DIR}\${MOD}.zip"; Expand-Archive "${DIR}\${MOD}.zip" -DestinationPath "${DIR}"; Rename-Item -Path "${DIR}\pwsh-${MOD}-main" -NewName "${DIR}\${MOD}";
```
