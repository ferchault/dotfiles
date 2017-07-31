#!/bin/bash
BASEDIR=$(dirname $(realpath "$BASH_SOURCE" ))

# Prompt
PS1='\[\e[37m\]$HCHAIN \[\e[32m\]\[\e[31;1m\]\h\[\e[37m\]:\[\e[32m\]\w \$\[\e[0m\] ' 
PS2="\u@\h:\w> "

# Pretty git log
alias gitlog="git log --oneline --abbrev-commit --all --graph --decorate --color" 

# Disable bell
setterm -blength 0 &> /dev/null

# Read SSH config
alias ssh='ssh -F "$BASEDIR/ssh-config"'
