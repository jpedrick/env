#!/bin/bash
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

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

