#!/bin/bash
#
# Links files in this directory to the current users home directory.

real_path () {
    _=`pwd`
    [ -d $DIR ] && DIR=$1
    [ -f $DIR ] && DIR=`dirname $1`
    cd $DIR && echo `pwd` && cd $_
}

SCRIPT_DIR=$(real_path $0)
SCRIPT_PATH=${SCRIPT_DIR}/`basename $0`
FORCE=0
PREFIX=$HOME

while getopts "p:" flag; do
    case "$flag" in
        p) PREFIX=$OPTARG ;;
    esac
done

PREFIX=${PREFIX%/}

function link() {
    [ -z $2 ] && DST=.$1 || DST=$2
    DST=${PREFIX}/$DST
    SRC=${SCRIPT_DIR}/$1
    ln -snf $SRC $DST
}

link vendor/oh-my-zsh .oh-my-zsh
link vendor/tmux-powerline .tmux-powerline
link vendor/base16-shell .base16-shell

link vim/vimrc .vimrc
link vim

link zsh/zshrc .zshrc
link zsh

link git/gitconfig .gitconfig
link git/gitignore .gitignore

link tmux/tmux.conf .tmux.conf
link tmux

link osx

# Handle scripts
if [[ `uname` == "Darwin" ]]; then
    BIN_PATH=Scripts
else
    BIN_PATH=bin
fi

[ -d $PREFIX/$BIN_PATH ] || mkdir $PREFIX/$BIN_PATH
for SCRIPT in `ls $SCRIPT_DIR/bin`; do
    link bin/$SCRIPT $BIN_PATH/$SCRIPT
done
