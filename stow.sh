#!/bin/bash

mkdir -p ~/.config/tmux

stow -v -R -t ~/ bash
stow -v -R -t ~/ git
stow -v -R -t ~/ vim
stow -v -R -t ~/ wezterm
stow -v -R -t ~/ zsh
stow -v -R -t ~/ zsh
stow -v -R -t ~/.config starship
stow -v -R -t ~/.config/tmux/ tmux
stow -v -R -t ~/Library/Application\ Support/Code/User vscode
