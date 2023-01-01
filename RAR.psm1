<#
  .SYNOPSIS
  .DESCRIPTION
#>

Param(
  [Parameter(
    Mandatory,
    HelpMessage="Enter file names..."
  )]
  [Alias("")]
  [string[]]$P_Files
)

function Compress-RAR() {
  ForEach ($File in (Get-ChildItem $($P_Files))) {
    & "$($env:ProgramFiles)\WinRAR\Rar.exe" a "$($File.Name + '.rar')" "$($File.FullName)"
  }
}

function Expand-RAR() {
  ForEach ($File in (Get-ChildItem "$($P_Files)")) {
    & "$($env:ProgramFiles)\WinRAR\Rar.exe" x "$($File.FullName)"
  }
}
