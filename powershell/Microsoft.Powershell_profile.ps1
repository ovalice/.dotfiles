# Modules/applications that should be installed:
# - fzf
# - posh-git
# - OhMyPosh
# - bat
# - PSFzf
# - fd


Import-Module posh-git


# Set up theme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
$env:POSH_GIT_ENABLED = $true # Make OhMyPosh aware of posh-git


# Set up autocomplete
Set-PSReadLineKeyHandler -Key Tab -Function Complete # Bash style autocomplete
Set-PSReadLineOption -BellStyle None


# Path shortcuts
function df { Set-Location -Path "$home\.dotfiles" }


# Set up bat
$env:BAT_PAGING = 'never' # Disable paging with bat
Remove-Item Alias:cat -Force
Set-Alias -Name cat -Value bat -Scope Global -Force


# Set up fzf
Set-Alias -Name fkill -Value Invoke-FuzzyKillProcess -Force
Set-Alias -Name fh    -Value Invoke-FuzzyHistory     -Force

## Go to directory based on search term
function ff {
    $fileIgnoreList = @(
        'node_modules',
        '.git',
        '.vs',
        'bin',
        'obj',
        '.idea'
    )
    $fileIgnoreArgs = ($fileIgnoreList | ForEach-Object { "--exclude '$_'" }) -join ' '

    # I could just write my own fzf invocation instead of relying on Invoke-Fzf,
    # but I haven't figured out how to stream the results of fd to fzf yet (instead of blocking the terminal).
    $originalFzfDefaultCommand = $env:FZF_DEFAULT_COMMAND
    $env:FZF_DEFAULT_COMMAND = "fd --type directory --hidden $fileIgnoreArgs"

    $result = Invoke-Fzf
    if ($result) {
        Set-Location $result
    }

    $env:FZF_DEFAULT_COMMAND = $originalFzfDefaultCommand
}

