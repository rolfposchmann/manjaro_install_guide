chshn
#/bin/zsh

nano .zshrc
source $HOME/.bash_aliases

#!/bin/sh

alias ls="ls --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias l="ls -la"

#Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
