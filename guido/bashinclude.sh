	#!/bin/bash
BASEDIR=$(dirname $(realpath "$BASH_SOURCE" ))

# Prompt
PS1='\[\e[37m\]$HCHAIN \[\e[32m\]\[\e[31;1m\]\h\[\e[37m\]:\[\e[32m\]\w \$\[\e[0m\] ' 
PS1="\[\e[0;32m\]\t \[\e[0;33m\]\w \[\e[0;37m\]\\n\[\e[0;31m\]\h \[\e[0;37m\]\$ \[\e[0m\]"
PS2="\u@\h:\w> "

# Pretty git log
alias gitlog="git log --oneline --abbrev-commit --all --graph --decorate --color" 
alias cdw="cd $WORKDIRPATH"

# Disable bell
setterm -blength 0 &> /dev/null
grep 'set bell-style none' ~/.inputrc &> /dev/null || echo 'set bell-style none' >> ~/.inputrc
grep 'set visualbell' ~/.vimrc &> /dev/null || echo 'set visualbell' >> ~/.vimrc

# Read SSH config
alias ssh='ssh -F "$BASEDIR/ssh-config"'
alias scp='scp -F "$BASEDIR/ssh-config"'

# Tunnel UniBas
alias boring='ssh -f -T -N -R 20000:localhost:24800 basil;ssh -f -N -L 3587:basil.vonrudorff.de:587 basil; ssh -f -N -L 4587:smtp.gmail.com:587 basil;ssh -f -N -L 4465:mail.univie.ac.at:465 basil'
alias ubasproxy='ssh -L 8999:localhost:8002 ubas -t ssh -D 8002 grudorff@pc-avl03.chemie.unibas.ch'

function automount {
	for driveletter in $(find /mnt/ -maxdepth 1 | grep '/drive-' | sed 's/.*-//')
	do
		mount | grep "/mnt/drive-$driveletter" > /dev/null
		if [ $? -eq 1 ]
		then
			sudo mount -t drvfs "$driveletter:" "/mnt/drive-$driveletter"
		fi
	done
}

function gitpoint {
	# check for dirty repositories
	BASEPATH=$(pwd)
	for i in $WORKDIRPATH/*
	do
		cd "$i"
		NUMLINES=$(git status --porcelain | wc -l)
		if [ "$NUMLINES" -ne "0" ]
		then
			cd $i
			git status
			return
		fi
	done

	# push current commits
	for i in $WORKDIRPATH/*
	do	
		echo "Updating repository $i"
		cd "$i"
		git pull
		git push
	done	
}

function tarscp {
	if [ "$#" -ne 3 ]
	then
		echo "Usage: tarscp HOST BASEDIR FILELIST"
	else
		ssh $1 "cd $2 && tar cf - -T $3" | pv | tar xf - &> /dev/null
	fi
}
function tablack {
	black -l 120 $1 && sed -e "s/    /\t/g"  -i $1
}
