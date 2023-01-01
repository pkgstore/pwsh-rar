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
  if (Test-Path -Path "$($ENV:ProgramFiles)\WinRAR\Rar.exe" -PathType "Leaf") {
    $RAR = "$($ENV:ProgramFiles)\WinRAR\Rar.exe"
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
  if (Test-Path -Path "$($ENV:ProgramFiles)\WinRAR\Rar.exe" -PathType "Leaf") {
    $RAR = "$($ENV:ProgramFiles)\WinRAR\Rar.exe"
  }

  ForEach ($File in (Get-ChildItem "$($P_Files)")) {
    & "$($RAR)" x "$($File.FullName)"
  }
}
