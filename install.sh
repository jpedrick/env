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

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall' -c 'q' 
vim -c 'so %' -c 'q' Align.vba 
git clone https://github.com/powerline/fonts.git powerline-fonts
pushd powerline-fonts
./install.sh
popd
cp .Xdefaults ~/
xrdb ~/.Xdefaults

pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

sudo apt-get install tmux

mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/

