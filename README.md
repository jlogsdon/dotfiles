# dotfiles

A collection of my setup files for the tools I use in a terminal.

## Setup

```
$ mkdir $HOME/etc # or wherever you want them to live
$ git clone --recursive git://github.com/jlogsdon/dotfiles.git $HOME/etc/dotfiles
$ cd $HOME/etc/dotfiles
$ ./install.sh
$ pip install powerline
$ vim +NeoBundleInstall +qall now
```

## Local Configuration

For ZSH settings local to the computer create a `$HOME/.zsh_local` file. This will be loaded after prezto is initialized.
