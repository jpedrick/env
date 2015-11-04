#!/bin/bash
set -ev
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

function on_exit(){
    echo $PROGRESS > $PROGRESS_FILE
}

trap 'error_exit ${LINENO}' ERR
trap 'on_exit ' EXIT


PROGRESS_FILE=env_install_progress.txt
if [ -f $PROGRESS_FILE ]; then LOADED_PROGRESS=$(<${PROGRESS_FILE}); fi
PROGRESS=${LOADED_PROGRESS:-0}

STEP=0

if (( PROGRESS < STEP )); then

mkdir -p ~/.vim/bundle
cp -P .vim/vim_plugins ~/.vim/
pushd ~/
ln -s .vim/vimrc ~/.vimrc
ln -s .vim .config/nvim
popd

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then

echo Install Nvim
git clone https://github.com/neovim/neovim.git
make
sudo make install

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall' -c 'q' 
vim -c 'so %' -c 'q' Align.vba 

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
git clone https://github.com/powerline/fonts.git powerline-fonts
pushd powerline-fonts
./install.sh
popd

((PROGRESS+=1))
fi
((STEP+=1))


if (( PROGRESS < STEP )); then
cp .Xdefaults ~/
xrdb ~/.Xdefaults

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo compile YouCompleteMe with clang-completer
pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Installing tmux
sudo apt-get install tmux

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Installing tmux package manager
mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Upgrading git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
git --version

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Installing git WebUI
git clone https://github.com/alberthier/git-webui.git
git config --global alias.webui \!$PWD/git-webui/release/libexec/git-core/git-webui

((PROGRESS+=1))
fi
((STEP+=1))

