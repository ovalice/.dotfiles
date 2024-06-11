Import-Module posh-git

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
$env:POSH_GIT_ENABLED = $true # Make OhMyPosh aware of posh-git

Set-PSReadLineKeyHandler -Key Tab -Function Complete # Bash style autocomplete
Set-PSReadLineOption -BellStyle None
