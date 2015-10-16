#!/bin/bash
set -e
me=`basename $0`

function error_exit
{
    local parent_lineno="$1"
    local message="$2"
    local code="${3:-1}"
    if [[ -n "$message" ]] ; then
        echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
    else
        echo "Error on or near line ${parent_lineno}; exiting with status ${code}"
    fi
    exit "${code}"
}

trap 'error_exit ${LINENO}' ERR

mkdir -p ~/.vim/bundle
cp .vim/vim_plugins ~/.vim/

echo Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall' -c 'q' 
vim -c 'so %' -c 'q' Align.vba 
git clone https://github.com/powerline/fonts.git powerline-fonts
pushd powerline-fonts
./install.sh
popd
cp .Xdefaults ~/
xrdb ~/.Xdefaults

echo compile YouCompleteMe with clang-completer
pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

echo Installing tmux
sudo apt-get install tmux

echo Installing tmux package manager
mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/

echo Upgrading git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
git --version

echo Installing git WebUI
git clone https://github.com/alberthier/git-webui.git
git config --global alias.webui \!$PWD/git-webui/release/libexec/git-core/git-webui

