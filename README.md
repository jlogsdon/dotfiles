# dotfiles

My (semi-)portable dotfiles. These are very specific to my workflow and not to be blindly installed, they are provided
as a reference for building your own environment.

## Setup

```
$ export DOTFILES_HOME=$HOME/etc # or wherever you want...
$ mkdir -p $DOTFILES_HOME # or wherever you want them to live
$ git clone --recursive git://github.com/jlogsdon/dotfiles.git $DOTFILES_HOME
$ cd $DOTFILES_HOME
$ ./install.sh
$ vim +NeoBundleInstall +qall now
```

## Local Configuration

ZSH can be configured further for your local computer with by creating `$HOME/.zsh_local`. Aliases should go in
`$HOME/.aliases`.

## ViM mode

Nearly everything works with ViM motion commands. Readline, tmux, zsh...

## Scripts

#### `gco [-p] <org> <repo>`

Clones a GitHub repository into `$HOME/Code/<org>.github.com/<repo>`. By default the repository is cloned using the
public `git://` URL; providing the `-p` flag will use the private `git@` URL.

#### `http-serve [port]`

A *very* dumb HTTP server that serves the current folder statically. The port defaults to 8000.

#### `open-project <project>`

My "IDE" work horse. Uses `z` to navigate to the given project and opens 3 tmux panes (across 2 windows) and a nvim
session for that project.

#### `shssh ...`

Pushes my server-specific dotfiles before SSHing up. Currently hard-coded to use dotfiles in
`$HOME/Library/server-dotfiles` and uploads to `/home/jlogsdon`.

#### `tcssh <aws-group-name> [panes]`

A tool for connecting to every server in an AWS group with tmux. Sessions will be tiled in at least one window (number
of tiles configurable). Each window syncs typing to all panes for that window.
