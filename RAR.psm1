function Compress-RAR() {
  <#
    .SYNOPSIS
      Compress 'RAR' archive.
    .DESCRIPTION
      -F
        File list.
      -L
        Compression level.
        Value: [0 | ... | 5].
        Default: 3.
      -V
        Specify version of archiving format.
        Value: [4 | 5].
        Default: 5.
      -PWD | -HP | -P
        Password. Encrypt both file data and headers.
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory, HelpMessage="File list.")]
    [Alias('Files', 'File', 'F')]
    [string[]]$Files,

    [Parameter(HelpMessage="Compression level. Value: [0 | ... | 5]. Default: 3.")]
    [ValidateRange(0,5)]
    [Alias('Level', 'L')]
    [int]$Level = 3,

    [Parameter(HelpMessage="Specify version of archiving format. Value: [4 | 5]. Default: 5.")]
    [ValidateRange(4,5)]
    [Alias('Version', 'Ver', 'V', 'MA')]
    [int]$Version = 5,

    [Parameter(HelpMessage="Password. Encrypt both file data and headers.")]
    [Alias('Password', 'PWD', 'P', 'HP')]
    [string]$Password
  )

  $RAR = "${PSScriptRoot}\Rar.exe"
  $RAR_PF = "${ENV:ProgramFiles}\WinRAR\Rar.exe"
  $RAR_PF86 = "${ENV:ProgramFiles(x86)}\WinRAR\Rar.exe"

  if ( Test-Path -Path "${RAR_PF}" -PathType "Leaf" ) {
    $RAR = "${RAR_PF}"
  } elseif ( Test-Path -Path "${RAR_PF86}" -PathType "Leaf" ) {
    $RAR = "${RAR_PF86}"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  ForEach ( $File in ( Get-ChildItem ${Files} ) ) {
    $CMD = @( "a", "-m${Level}", "-ma${Version}" )
    if ( -not ( [string]::IsNullOrEmpty(${Password}) ) ) { $CMD += "-hp${Password}" }
    $CMD += @( "$( ${File}.Name + '.rar' )", "$( ${File}.FullName )" )
    & "${RAR}" $CMD
  }
}

function Expand-RAR() {
  <#
    .SYNOPSIS
      Expand 'RAR' archive.
    .DESCRIPTION
      -F
        File list.
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory, HelpMessage="File list.")]
    [Alias('Files', 'File', 'F')]
    [string[]]$Files
  )

  $RAR = "${PSScriptRoot}\Rar.exe"
  $RAR_PF = "${ENV:ProgramFiles}\WinRAR\Rar.exe"
  $RAR_PF86 = "${ENV:ProgramFiles(x86)}\WinRAR\Rar.exe"

  if ( Test-Path -Path "${RAR_PF}" -PathType "Leaf" ) {
    $RAR = "${RAR_PF}"
  } elseif ( Test-Path -Path "${RAR_PF86}" -PathType "Leaf" ) {
    $RAR = "${RAR_PF86}"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  ForEach ( $File in ( Get-ChildItem "${Files}" ) ) {
    $CMD = @( "x", "$( ${File}.FullName )" )
    & "${RAR}" $CMD
  }
}
