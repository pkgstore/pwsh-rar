@{
  RootModule = 'PkgStore.RAR.psm1'
  ModuleVersion = '1.0.0'
  GUID = '7425b74b-b74d-4bb5-bbdf-412008b793dc'
  Author = 'Kitsune Solar'
  CompanyName = 'v77 Development'
  Copyright = '(c) 2023 v77 Development. All rights reserved.'
  Description = 'Compress end expand RAR archive.'
  PowerShellVersion = '7.1'
  RequiredModules = @('PkgStore.Kernel')
  FunctionsToExport = @('Compress-RAR', 'Expand-RAR')
  PrivateData = @{
    PSData = @{
      Tags = @('pwsh', 'rar')
      LicenseUri = 'https://github.com/pkgstore/pwsh-rar/blob/main/LICENSE'
      ProjectUri = 'https://github.com/pkgstore/pwsh-rar'
    }
  }
}
