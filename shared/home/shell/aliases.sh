#!/bin/bash

secret() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "${1:-32}" | head -n 1
}

secretx() {
  cat /dev/urandom | tr -dc '[:graph:]' | fold -w "${1:-32}" | head -n 1
}
alias c=clear
alias g=git
alias v=nvim
alias k="kubectl"
alias kc="kubectx"
alias dig="doggo"
alias dog="doggo"
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