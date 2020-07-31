chshn
#/bin/zsh

nano .zshrc
source $HOME/.bash_aliases

#!/bin/sh

alias ls="ls --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias l="ls -la"

#Tilix fix: https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
