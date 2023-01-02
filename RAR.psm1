function Compress-RAR() {
  <#
    .SYNOPSIS
      Compress 'RAR' archive.
    .DESCRIPTION
  #>

  [CmdletBinding()]

  Param(
    [Parameter(
      Mandatory,
      HelpMessage="Enter file names..."
    )]
    [Alias("F")]
    [string[]]$P_Files
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

  ForEach ($File in (Get-ChildItem $($P_Files))) {
    & "$($RAR)" a "$($File.Name + '.rar')" "$($File.FullName)"
  }
}

function Expand-RAR() {
  <#
    .SYNOPSIS
      Expand 'RAR' archive.
    .DESCRIPTION
  #>

  [CmdletBinding()]

  Param(
    [Parameter(
      Mandatory,
      HelpMessage="Enter file names..."
    )]
    [Alias("F")]
    [string[]]$P_Files
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

  ForEach ($File in (Get-ChildItem "$($P_Files)")) {
    & "$($RAR)" x "$($File.FullName)"
  }
}
