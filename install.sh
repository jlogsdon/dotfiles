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

link gitconfig
link gitignore
link inputrc

link zshrc
link vendor/prezto .zprezto

mkdir -p "$PREFIX/.config"
link nvim .config/nvim

mkdir -p "$PREFIX/bin"
for SCRIPT in bin/*; do
	link "$SCRIPT" "$SCRIPT"
done
