function Compress-RAR() {
  <#
    .SYNOPSIS
      Compress 'RAR' archive.
    .DESCRIPTION
      -F
        File list.
      -M
        Compression level (0-store | 3-default | 5-maximal).
      -MA
        Specify version of archiving format (4 | 5).
        Default: 5.
      -PWD | -HP | -P
        Password. Encrypt both file data and headers.
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory, HelpMessage="File list.")]
    [Alias("F", "File", "Files")]
    [string[]]$P_File,

    [Parameter(HelpMessage="Compression level (0-store | 3-default | 5-maximal). Default: 3.")]
    [ValidateRange(0,5)]
    [Alias("M", "CompressionLevel", "Level")]
    [int]$P_M = 3,

    [Parameter(HelpMessage="Specify version of archiving format (4 | 5). Default: 5.")]
    [ValidateRange(4,5)]
    [Alias("MA", "Version")]
    [int]$P_MA = 5,

    [Parameter(HelpMessage="Password. Encrypt both file data and headers.")]
    [Alias("PWD", "HP", "P", "Password")]
    [string]$P_PWD
  )

  $RAR = "$($PSScriptRoot)\Rar.exe"
  $RAR_PF = "$($ENV:ProgramFiles)\WinRAR\Rar.exe"
  $RAR_PF86 = "$($ENV:ProgramFiles(x86))\WinRAR\Rar.exe"

  if (Test-Path -Path "$($RAR_PF)" -PathType "Leaf") {
    $RAR = "$($RAR_PF)"
  } elseif (Test-Path -Path "$($RAR_PF86)" -PathType "Leaf") {
    $RAR = "$($RAR_PF86)"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  if (-not ([string]::IsNullOrEmpty($P_PWD))) { $P_PWD = "-hp$($P_PWD)" }

  ForEach ($File in (Get-ChildItem $($P_File))) {
    & "$($RAR)" -m$($P_M) -ma$($P_MA) $($P_PWD) a "$($File.Name + '.rar')" "$($File.FullName)"
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
    [Alias("F", "File", "Files")]
    [string[]]$P_File
  )

  $RAR = "$($PSScriptRoot)\Rar.exe"
  $RAR_PF = "$($ENV:ProgramFiles)\WinRAR\Rar.exe"
  $RAR_PF86 = "$($ENV:ProgramFiles(x86))\WinRAR\Rar.exe"

  if (Test-Path -Path "$($RAR_PF)" -PathType "Leaf") {
    $RAR = "$($RAR_PF)"
  } elseif (Test-Path -Path "$($RAR_PF86)" -PathType "Leaf") {
    $RAR = "$($RAR_PF86)"
  } else {
    Write-Error -Message "'Rar.exe' not found!" -ErrorAction "Stop"
  }

  ForEach ($File in (Get-ChildItem "$($P_File)")) {
    & "$($RAR)" x "$($File.FullName)"
  }
}
