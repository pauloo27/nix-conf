#!/bin/bash

## Upgrade
alias upgrade="flatpak update && yay -Syu --cleanmenu=false --diffmenu=false --editmenu=false --sudoloop && notify-send 'System upgraded'"

# Random secret
alias secret="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1"

# Clear
alias c=clear

# Git cool
alias g=git

## Init
alias ,init="git init"

## Log
alias ,l="git log"
alias ,ls="git log --show-signatures"

## Merge
alias ,m="git merge"

## Submodule foreach
alias ,fe="git submodule foreach"

## Status
alias ,s="git status -s" # Cool looking Status 😎
alias ,st="git status"
alias ,ms="git diff --name-only --diff-filter=U" # Files to be merged

## Add to .gitignore
,ig() {
  echo "$@" >> .gitignore
}

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

## Push/Pull
alias ,ps="git push"
alias ,pl="git pull"

## Stash
alias ,sh="git stash --include-untracked --message"

## Push current branch
,psc() {
  git push -u origin $(git branch --show-current)
}

## Worktree
alias ,w="git worktree"

### Create a worktree from an existing branch: <sourceBranch>
,wa() {
  SOURCE_BRANCH=$1

  if [ -z "$SOURCE_BRANCH" ]; then
    echo 'usage: <sourceBranch>'
    return 1
  fi

  REPO_ROOT=$(git rev-parse --show-toplevel)
  git worktree add "$REPO_ROOT/.git/wt/$SOURCE_BRANCH" "$SOURCE_BRANCH"
}

### Create worktree: <newBranch> [sourceBranch]
,wc() {
  NEW_BRANCH=$1
  SOURCE_BRANCH=$2

  if [ -z "$NEW_BRANCH" ]; then
    echo 'usage: <newBranch> [sourceBranch]'
    return 1
  fi

  REPO_ROOT=$(git rev-parse --show-toplevel)

  if [ -z "$SOURCE_BRANCH" ]; then
    git worktree add "$REPO_ROOT/.git/wt/$NEW_BRANCH" -b "$NEW_BRANCH"
  else
    git worktree add "$REPO_ROOT/.git/wt/$NEW_BRANCH" -b "$NEW_BRANCH" "$SOURCE_BRANCH"
  fi
}

### Switch (WARP) to a worktree: <targetBranch>
,ww() {
  TARGET_BRANCH=$1
  if [ -z "$TARGET_BRANCH" ]; then
    echo 'usage: <targetBranch>'
    return 1
  fi
  
  echo "Worktree warp in 3... 2..."
  
  WORKTREE_PATH=$(git worktree list --porcelain | grep -B 2 -A 1 "branch refs/heads/$TARGET_BRANCH" | grep "worktree" | awk '{print $2}')
  
  if [ -z "$WORKTREE_PATH" ]; then
    echo "Worktree for branch $TARGET_BRANCH not found!"
    return 1
  fi
  
  if [ -d "$WORKTREE_PATH" ]; then
    cd "$WORKTREE_PATH" || return 1
    echo "... 🌌 You are now in worktree $TARGET_BRANCH"
  else
    echo "Worktree directory for branch $TARGET_BRANCH exists in git but not on filesystem!"
    return 1
  fi
}

### Tab complete...
_ww_complete() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  
  # Get the list of branches from git
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=($(compgen -W "$(git worktree list --porcelain | grep 'branch refs/heads/' | sed 's/branch refs\/heads\///g')" -- "$cur"))
  fi
}
complete -F _ww_complete ,ww

## Push as PR (gitea supports, not sure the others)
### this is wip tho, kinda broken
,prm() {
  CURRENT_BRANCH=$(git branch --show-current)

  cp ~/.config/PR_EDITMSG /tmp/PR_EDITMSG
  vim /tmp/PR_EDITMSG
  RAW_MESSAGE=$(sed '/^#/d' /tmp/PR_EDITMSG)
  rm /tmp/PR_EDITMSG

  TITLE=$(echo "$RAW_MESSAGE" | head -n 1)
  DESCRIPTION=$(echo "$RAW_MESSAGE" | tail -n +2)

  git push origin HEAD:refs/for/master/$CURRENT_BRANCH -o title="$TITLE" -o description="$DESCRIPTION"
}

# Cool
alias ipp="curl ifconfig.io"
alias eslint="npx eslint"
alias k="kubectl"

mkcd () {
  mkdir "$1"
  cd "$1"
}

# Nix + Tmux + "np"

## Develop shell but not bash
alias ,nd="np dev"

## Load a dev profile
alias ,np="np run"

## Start nix shell with pkgs
alias ,nz="np shell"

## Exec package from nixpkgs
alias ,nx="np x"

## Open tmux with profiles
alias ,nt="np tmux"

## Set tmux folder profile
alias ,ns="np set"

## Kill current tmux session
,tkk() {
  tmux kill-session
}

# Color
alias ip="ip --color=auto"
alias diff='diff --color=auto'
alias ls="ls --color=auto"

alias p=pnpm

# vim
alias vim=nvim
alias v=nvim

