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
cp -f .vim/vim_plugins ~/.vim/
cp -f .vim/vimrc ~/.vim/
pushd ~/
ln -snf .vim/vimrc ~/.vimrc
ln -snf .vim .config/nvim
popd

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then

echo Install Nvim
git clone https://github.com/neovim/neovim.git
pushd neovim
make
sudo make install
popd 

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
echo Install Vundle
mkdir -p ~/.vim/bundle
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
sudo apt-get update || true
sudo apt-get install git gitk
git --version

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
git config --global user.name "$(getent passwd $USER | awk '{split($0,ent,":"); print ent[5]}')"
git config --global user.name 

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
git config --global push.default simple

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then

if [ -z ${GIT_EMAIL+x} ]; then echo "Must set GIT_EMAIL environment variable to proceed" exit 1; fi
git config --global user.email "${GIT_EMAIL}"
git config --global user.email 

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

if (( PROGRESS < STEP )); then

sudo apt-add-repository ppa:george-edison55/cmake-3.x
sudo apt-get update || true
sudo apt-get install cmake

((PROGRESS+=1))
fi
((STEP+=1))

ST_GIT=http://git.suckless.org/st
if (( PROGRESS < STEP )); then
echo Installing st
sudo apt-get install libxt-dev libxft-dev

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then

git clone ${ST_GIT}

((PROGRESS+=1))
fi
((STEP+=1))

if (( PROGRESS < STEP )); then
pushd st
cp ../st-config/config.h .
make
make install PREFIX=$HOME
popd
((PROGRESS+=1))
fi
((STEP+=1))

echo done
