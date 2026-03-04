#!/bin/bash

alias secret="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1"
alias c=clear
alias g=git
alias v=nvim
alias k="kubectl"
alias p=pnpm

alias diff='diff --color=auto'
alias ls="ls --color=auto"

mkcd () {
  mkdir "$1"
  cd "$1"
}

# push current branch
psc() {
  git push -u origin $(git branch --show-current)
}

# add to .gitignore
ig() {
  echo "$@" >> .gitignore
}

## this is arch specific, fix later
alias upgrade="flatpak update && yay -Syu --cleanmenu=false --diffmenu=false --editmenu=false --sudoloop"
