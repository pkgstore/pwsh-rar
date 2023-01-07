function Compress-RAR() {
  <#
    .SYNOPSIS
      Compress 'RAR' archive.

    .DESCRIPTION

    .PARAMETER Files
      File list.
      Alias: '-F'.

    .PARAMETER Level
      Compression level.
      Value: [0 | ... | 5].
      Default: 3.
      Alias: '-L'.

    .PARAMETER Version
      Specify version of archiving format.
      Value: [4 | 5].
      Default: 5.
      Alias: '-V'.

    .PARAMETER Password
      Password. Encrypt both file data and headers.
      Alias: '-P'.

    .EXAMPLE
      Compress-RAR -F '*.iso', '*.txt'

    .EXAMPLE
      Compress-RAR -F '*.txt' -L 5

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
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

  # RAR executable file.
  ${APP} = "${PSScriptRoot}\Rar.exe"

  # Checking if a 'Rar.exe' exist.
  if ( Test-Path -Path "${env:ProgramFiles}\WinRAR\Rar.exe" -PathType "Leaf" ) {
    ${APP} = "${env:ProgramFiles}\WinRAR\Rar.exe"
  } elseif ( Test-Path -Path "${env:ProgramFiles(x86)}\WinRAR\Rar.exe" -PathType "Leaf" ) {
    ${APP} = "${env:ProgramFiles(x86)}\WinRAR\Rar.exe"
  } else {
    Write-Msg -T 'E' -M "'Rar.exe' not found!" -A 'Stop'
  }

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    # Composing a app command.
    ${CMD} = @( "a", "-m${Level}", "-ma${Version}" )
    if ( -not ( [string]::IsNullOrEmpty(${Password}) ) ) { ${CMD} += "-hp${Password}" }
    ${CMD} += @( "$( ${F}.FullName + '.rar' )", "$( ${F}.FullName )" )

    # Running a app.
    & "${APP}" ${CMD}
  }
}

function Expand-RAR() {
  <#
    .SYNOPSIS
      Expand 'RAR' archive.

    .DESCRIPTION

    .PARAMETER Files
      File list.
      Alias: '-F'.

    .EXAMPLE
      Expand-RAR -F '*.rar'

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [SupportsWildcards()]
    [Alias('F')]
    [string[]]${Files}
  )

  # RAR executable file.
  ${APP} = "${PSScriptRoot}\App\Rar.exe"

  # Checking if a 'Rar.exe' exist.
  if ( Test-Path -Path "${env:ProgramFiles}\WinRAR\Rar.exe" -PathType "Leaf" ) {
    ${APP} = "${env:ProgramFiles}\WinRAR\Rar.exe"
  } elseif ( Test-Path -Path "${env:ProgramFiles(x86)}\WinRAR\Rar.exe" -PathType "Leaf" ) {
    ${APP} = "${env:ProgramFiles(x86)}\WinRAR\Rar.exe"
  } else {
    Write-Msg -T 'E' -M "'Rar.exe' not found!" -A 'Stop'
  }

  ForEach ( ${F} in ( Get-ChildItem ${Files} ) ) {
    # Composing a app command.
    ${CMD} = @( "x", "$( ${F}.FullName )" )

    # Running a app.
    & "${APP}" ${CMD}
  }
}
