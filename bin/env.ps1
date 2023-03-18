$Path = $PSScriptRoot
Write-Host $Path\hugo.exe
Set-Alias -Value $Path\hugo.exe -Name hugo -Scope Global