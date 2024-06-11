#!/bin/bash

set -e

echo 'Warning: This script will overwrite existing dotfiles and can delete unrelated files when left in directories for to be installed tools.'
confirmation=""

while [[ $confirmation != "y" ]]; do
    if [[ $confirmation == "n" ]]; then
        echo 'Aborting.'
        exit
    fi
    read -rp 'Proceed? [y/n] ' confirmation
done
echo ''

dotfilesPath="$(dirname "$(readlink -f "$0")")"
decorativeLine='----------------------------------'



echo 'Updating Linux.'
echo $decorativeLine

sudo apt update
sudo apt -y upgrade

echo ''



echo 'Installing tooling.'
echo $decorativeLine

sudo apt install -y curl git build-essential ripgrep fd-find

echo ''



echo 'Configuring Git.'
echo $decorativeLine

read -rp 'Enter git.name: ' gitName
read -rp 'Enter git.email: ' gitEmail

localGitConfig="[user]
    name = $gitName
    email = $gitEmail
"

ln -sf "$dotfilesPath/git/.wsl.gitconfig" "$HOME/.gitconfig"
echo ".gitconfig has been placed under $HOME."

echo "$localGitConfig" >"$HOME/.local.gitconfig"
echo ".local.gitconfig has been placed under $HOME."

echo ''



echo 'Configuring Neovim.'
echo $decorativeLine

wget -q https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage
chmod +x ./nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim
echo 'Neovim 0.10.0 has been installed.'

rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config"
ln -sf "$dotfilesPath/neovim" "$HOME/.config/nvim"
echo "Neovim config has been placed under $HOME/.config/nvim."

echo ''



echo 'Installing NVM.'
echo $decorativeLine

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
nvm use --lts

echo ''



echo 'Done!'
echo 'Make sure to start a new shell to load the new config.'
