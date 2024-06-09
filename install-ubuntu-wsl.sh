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



sudo add-apt-repository ppa:neovim-ppa/unstable



echo 'Updating Linux.'
echo $decorativeLine

sudo apt update
sudo apt -y upgrade

echo ''



echo 'Installing tooling.'
echo $decorativeLine

sudo apt install -y curl git build-essential ripgrep fd-find neovim



echo 'Configuring Git.'
echo $decorativeLine

read -rp 'Enter git.name: ' gitName
read -rp 'Enter git.email: ' gitEmail

localGitConfig="[user]
    name = $gitName
    email = $gitEmail
"

ln -sf "$dotfilesPath/git/.gitconfig" "$HOME/.gitconfig"
echo ".gitconfig has been placed under $HOME."

echo "$localGitConfig" >"$HOME/.local.gitconfig"
echo ".local.gitconfig has been placed under $HOME."

echo ''



echo 'Configuring Neovim.'
echo $decorativeLine

rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config"
ln -sf "$dotfilesPath/neovim" "$HOME/.config/nvim"
echo "Neovim config has been placed under $HOME/.config/nvim."

echo ''



echo 'Installing NVM.'
echo $decorativeLine

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts
nvm use --lts

echo ''



echo 'Done!'
