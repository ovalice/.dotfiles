# dotfiles
Here you can find my dotfiles. I've tried to make them as multiplatform as possible.

## What's inside
- .gitconfig
- Neovim configuration
- Windows Powershell profile with OhMyPosh
- Windows Terminal settings
- .ideavimrc for Jetbrains IDEs (only Rider at the moment)

## Installation
To install the dotfiles, use the installation script for your platform located at the root of the repository.

### Windows
The Windows installation script requires administrator privileges to run.
You should probably run the script with Conhost instead of Windows Terminal, to prevent conflicts while installing the Windows Terminal settings.

```powershell
# Run Conhost as administrator:
# 1. Press Win + R
# 2. Enter 'conhost.exe powershell.exe'
# 3. Press Ctrl + Shift + Enter

git clone https://github.com/ovalice/.dotfiles "$home\.dotfiles"
& "$home\.dotfiles\install-windows.ps1"
```

If the current execution policy is not set (`Undefined`), make sure to run the installation script as `Unrestricted`.

```powershell
powershell -ExecutionPolicy Unrestricted -File "$home\.dotfiles\install-windows.ps1"
```
