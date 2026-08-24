#!/bin/bash

# LC_ALL=C: BSD tr errors on non-UTF-8 bytes from /dev/urandom
secret() {
  LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w "${1:-32}" | head -n 1
}

secretx() {
  LC_ALL=C tr -dc '[:graph:]' < /dev/urandom | fold -w "${1:-32}" | head -n 1
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