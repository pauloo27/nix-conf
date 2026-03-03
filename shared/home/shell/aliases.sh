#!/bin/bash

alias secret="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1"
alias c=clear
alias g=git
alias v=nvim
alias k="kubectl"
alias p=pnpm

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

## TODO: drop those

## Upgrade
alias upgrade="flatpak update && yay -Syu --cleanmenu=false --diffmenu=false --editmenu=false --sudoloop"

## Log
alias ,l="git log"
alias ,ls="git log --show-signatures"

## Status
alias ,s="git status -s" # Cool looking Status 😎
alias ,st="git status"
alias ,ms="git diff --name-only --diff-filter=U" # Files to be merged

## Show
alias ,ss="git show"

## Add 
alias ,a="git add" 
alias ,aa="git add ." 
alias ,ap="git add -p" # Interactive

## Un-add (remove?)
alias ,rm="git restore --staged"

## Edit last commit
alias ,ed="git commit --amend" # Edit last commit

## Commit
alias ,c="git commit"
alias ,ca="git commit -a" # Add all
alias ,cm="git commit -m" # Commit with message

alias ,d="git diff"
alias ,dc="git diff --cached" # All cached 
alias ,ds="git diff --staged" # All (even added)

## Clone
alias ,cl="git clone"

## Reset
alias ,rs="git restore" # Reset

## Branch
alias ,b="git branch" # Create new branch
alias ,sw="git switch" # Switch branch

## Stash
alias ,sh="git stash --include-untracked"
