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



Write-Host 'Installing/updating useful tooling.'
Write-Host $decorativeLine

winget install -e --id Microsoft.PowerShell
winget install -e --id=JanDeDobbeleer.OhMyPosh
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id=Neovim.Neovim -v '0.10.0'
winget install -e --id CoreyButler.NVMforWindows     # nvim dependency (LSPs)
winget install -e --id 7zip.7zip                     # nvim dependency (Mason)
winget install -e --id=BurntSushi.ripgrep.MSVC       # nvim dependency (Telescope)
winget install -e --id=sharkdp.fd                    # nvim dependency (Telescope)

$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User')

nvm install lts
nvm use lts

Write-Host ''
Write-Host 'Finished installing/updating tooling.'
Write-Host ''



Write-Host 'Installing Fira Code Nerd Font.'
Write-Host $decorativeLine

$archivePath = "$home\AppData\Local\Temp\FiraCode.zip"
$extractPath = "$home\AppData\Local\Temp\FiraCode"
$fontsPath = "$home\AppData\Local\Microsoft\Windows\Fonts"

$allFontFilesInstalled = (Get-ChildItem -Path "$fontsPath\FiraCodeNerdFont*").Count -ge 18

if ($allFontFilesInstalled) {
    Write-Host 'Fira Code is already installed.'
}
else {
    try {
        Invoke-WebRequest -Uri 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip' -OutFile $archivePath
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
        Write-Host 'Fira Code has been fully installed.'
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



Write-Host 'Configuring Powershell.'
Write-Host $decorativeLine

New-Item -ItemType SymbolicLink `
    -Target "$dotfilesPath\powershell\Microsoft.Powershell_profile.ps1" `
    -Path $PROFILE `
    -Force `
    | Out-Null

Write-Host "Powershell config has been placed under $PROFILE."

Write-Host ''



Write-Host 'Configuring Windows Terminal.'
Write-Host $decorativeLine

New-Item -ItemType Directory -Path "$home\repos" -Force | Out-Null   # Default starting directory for Windows Powershell
New-Item -ItemType SymbolicLink `
    -Target "$dotfilesPath\windows-terminal\settings.json" `
    -Path "$home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
    -Force `
    | Out-Null

Write-Host "Windows Terminal config has been placed under $home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json."

Write-Host ''



Write-Host 'Configuring Neovim.'
Write-Host $decorativeLine

Remove-Item -Path "$home\AppData\Local\nvim" -Recurse -Force
New-Item -ItemType SymbolicLink -Target "$dotfilesPath\neovim" -Path "$home\AppData\Local\nvim" -Force | Out-Null
Write-Host "Neovim config has been placed under $home\AppData\Local\nvim."

Write-Host ''



Write-Host 'Done!'
Write-Host 'You should probably verify whether some stuff requires antivirus exclusions (OhMyPosh).'