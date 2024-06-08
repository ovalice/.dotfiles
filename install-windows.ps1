#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

Write-Host 'Warning: This script will overwrite existing dotfiles and can delete unrelated files when left in directories for to be installed tools.'
while ($confirmation -ne 'y') {
    if ($confirmation -eq 'n') {
        Write-Host 'Aborting.'
        exit
    }

    $confirmation = Read-Host 'Proceed? [y/n]'
}
Write-Host ''

$dotfilesPath = Split-Path -Parent $PSCommandPath
$decorativeLine = '----------------------------------'



Write-Host 'Installing InconsolotaGo Nerd Font.'
Write-Host $decorativeLine

$archivePath = "$home\AppData\Local\Temp\InconsolataGo.zip"
$extractPath = "$home\AppData\Local\Temp\InconsolotaGo"
$fontsPath = "$home\AppData\Local\Microsoft\Windows\Fonts"

$allFontFilesInstalled = (Get-ChildItem -Path "$fontsPath\InconsolataGoNerdFont*").Count -ge 6

if ($allFontFilesInstalled) {
    Write-Host 'InconsolotaGo Nerd Font is already installed.'
}
else {
    try {
        Invoke-WebRequest -Uri 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/InconsolataGo.zip' -OutFile $archivePath
        Expand-Archive -Path $archivePath -DestinationPath $extractPath -Force
        
        Get-ChildItem -Path $extractPath -Filter '*.ttf' | ForEach-Object {
            $destination = Join-Path -Path $fontsPath -ChildPath $_.Name

            if (!(Test-Path $destination)) {
                Copy-Item -Path $_.FullName -Destination $destination -Force
                New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' -Name $_.Name -Value $destination -Force | Out-Null

                Write-Host "Installed $($_.Name)."
            }
        }
    
        Write-Host ''
        Write-Host 'InconsolotaGo Nerd Font has been fully installed.'
    }
    finally {
        Remove-Item -Path $archivePath -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ''



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
Write-Host ".gitconfig has been placed under $home."

$localGitConfig | Out-File -FilePath "$home\.local.gitconfig" -Encoding utf8 -Force
Write-Host ".local.gitconfig has been placed under $home."

Write-Host ''



Write-Host 'Configuring Neovim.'
Write-Host $decorativeLine

Remove-Item -Path "$home\AppData\Local\nvim" -Recurse -Force
New-Item -ItemType SymbolicLink -Target "$dotfilesPath\neovim" -Path "$home\AppData\Local\nvim" -Force | Out-Null
Write-Host "Neovim config has been placed under $home\AppData\Local\nvim."

Write-Host ''



Write-Host 'Done.'