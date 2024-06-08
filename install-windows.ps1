#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

Write-Host 'Warning: This script will overwrite existing dotfiles.'
while ($confirmation -ne 'y')
{
    if ($confirmation -eq 'n') {
        Write-Host 'Aborting.'
        exit
    }

    $confirmation = Read-Host 'Proceed? [y/n]'
}
Write-Host ''

$dotfilesPath = Split-Path -Parent $PSCommandPath
$decorativeLine = '----------------------------------'

Write-Host 'Configuring Git.'
Write-Host $decorativeLine

$gitName = Read-Host -Prompt 'Enter git.name'
$gitEmail = Read-Host -Prompt 'Enter git.email'
$localGitConfig = @"
[user]
    name = $gitName
    email = $gitEmail
"@

Write-Host ''

New-Item -ItemType SymbolicLink -Target "$dotfilesPath\git\.windows.gitconfig" -Path "$home\.gitconfig" -Force | Out-Null
Write-Host ".gitconfig has been installed under $home."

$localGitConfig | Out-File -FilePath "$home\.local.gitconfig" -Encoding utf8 -Force
Write-Host ".local.gitconfig has been installed under $home."

Write-Host ''