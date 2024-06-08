#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

Write-Host 'Warning: This script will overwrite existing dotfiles and can delete unrelated files when left in directories for to be installed tools.'
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

Write-Host 'Configuring Neovim.'
Write-Host $decorativeLine

Remove-Item -Path "$home\AppData\Local\nvim" -Recurse -Force
New-Item -ItemType SymbolicLink -Target "$dotfilesPath\neovim" -Path "$home\AppData\Local\nvim" -Force | Out-Null
Write-Host "Neovim config has been placed under $home\AppData\Local\nvim."

Write-Host ''

Write-Host 'Done.'