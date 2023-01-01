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

  ForEach ($File in (Get-ChildItem $($P_Files))) {
    & "$($ENV:ProgramFiles)\WinRAR\Rar.exe" a "$($File.Name + '.rar')" "$($File.FullName)"
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

  ForEach ($File in (Get-ChildItem "$($P_Files)")) {
    & "$($ENV:ProgramFiles)\WinRAR\Rar.exe" x "$($File.FullName)"
  }
}
