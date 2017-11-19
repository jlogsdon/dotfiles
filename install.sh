#!/usr/bin/env sh
set -e

real_path () {
	[ -d "$1" ] && target="$1" || target=$(dirname "$1")
	echo "$(cd "$target" || exit; pwd)"
}

SCRIPT_DIR=$(real_path "$0")
PREFIX=$HOME

while getopts "p:" flag; do
	case "$flag" in
	p) PREFIX=$OPTARG ;;
	esac
done

PREFIX=${PREFIX%/}

link() {
	[ -z "$2" ] && DST=".$1" || DST="$2"
	echo "$1 => $DST"
	DST=${PREFIX}/$DST
	SRC=${SCRIPT_DIR}/$1
	ln -snf "$SRC" "$DST"
}
checkout() {
	DST="$PREFIX/$1"
	SRC="$2"

	[ -d "$DST" ] || git clone "$SRC" "$DST"
}

link gemrc
link gitconfig
link gitignore
link inputrc

mkdir -p "$PREFIX/.local"
checkout .local/rbenv https://github.com/rbenv/rbenv
checkout .local/rbenv/plugins/ruby-build https://github.com/rbenv/ruby-build
checkout .local/nvm https://github.com/creationix/nvm
checkout .local/tmux/plugins/tpm https://github.com/tmux-plugins/tpm

link tmux.conf
link vendor/prezto .zprezto
link zsh
link zalias
link zshrc
link zlogin
link zlogout
link zpreztorc
link zprofile
link zenv

mkdir -p "$PREFIX/.config"
link nvim .config/nvim

mkdir -p "$PREFIX/bin"
for SCRIPT in bin/*; do
	link "$SCRIPT" "$SCRIPT"
done
