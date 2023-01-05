function Compress-RAR() {
  <#
    .SYNOPSIS
      Compress 'RAR' archive.

    .DESCRIPTION

    .PARAMETER F
      File list.

    .PARAMETER L
      Compression level.
      Value: [0 | ... | 5].
      Default: 3.

    .PARAMETER V
      Specify version of archiving format.
      Value: [4 | 5].
      Default: 5.

    .PARAMETER P
      Password. Encrypt both file data and headers.
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [SupportsWildcards()]
    [Alias('F')]
    [string[]]${Files},

    [ValidateRange(0,5)]
    [Alias('L')]
    [int]${Level} = 3,

    [ValidateRange(4,5)]
    [Alias('V')]
    [int]${Version} = 5,

    [Alias('P')]
    [string]${Password}
  )

  ${RAR} = "${PSScriptRoot}\Rar.exe"
  ${RAR_PF} = "${ENV:ProgramFiles}\WinRAR\Rar.exe"
  ${RAR_PF86} = "${ENV:ProgramFiles(x86)}\WinRAR\Rar.exe"

  if ( Test-Path -Path "${RAR_PF}" -PathType "Leaf" ) {
    ${RAR} = "${RAR_PF}"
  } elseif ( Test-Path -Path "${RAR_PF86}" -PathType "Leaf" ) {
    ${RAR} = "${RAR_PF86}"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    ${FullName} = "$( ${F}.FullName )"
    ${CMD} = @( "a", "-m${Level}", "-ma${Version}" )
    if ( -not ( [string]::IsNullOrEmpty(${Password}) ) ) { ${CMD} += "-hp${Password}" }
    ${CMD} += @( "$( ${FullName} + '.rar' )", "${FullName}" )

    & "${RAR}" ${CMD}
  }
}

function Expand-RAR() {
  <#
    .SYNOPSIS
      Expand 'RAR' archive.

    .DESCRIPTION

    .PARAMETER F
      File list.
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [SupportsWildcards()]
    [Alias('F')]
    [string[]]${Files}
  )

  ${RAR} = "${PSScriptRoot}\Rar.exe"
  ${RAR_PF} = "${ENV:ProgramFiles}\WinRAR\Rar.exe"
  ${RAR_PF86} = "${ENV:ProgramFiles(x86)}\WinRAR\Rar.exe"

  if ( Test-Path -Path "${RAR_PF}" -PathType "Leaf" ) {
    ${RAR} = "${RAR_PF}"
  } elseif ( Test-Path -Path "${RAR_PF86}" -PathType "Leaf" ) {
    ${RAR} = "${RAR_PF86}"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    ${FullName} = "$( ${F}.FullName )"
    ${CMD} = @( "x", "${FullName}" )

    & "${RAR}" ${CMD}
  }
}
