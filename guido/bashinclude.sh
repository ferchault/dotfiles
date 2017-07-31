#!/bin/bash
BASEDIR=$(dirname $(realpath "$BASH_SOURCE" ))
alias ssh='ssh -F "$BASEDIR/ssh-config"'
