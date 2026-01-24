{ pkgs, config, ... }:
{
  home.sessionVariables = {
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    EDITOR = "nvim";
    GOPATH = "$HOME/dev/go";
    ZVM_INIT_MODE = "sourcing";
  };

  home.sessionPath = [
    "$HOME/dev/go/bin"
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
      };
      golang = {
        symbol = " ";
      };
      nix_shell = {
        symbol = "󱄅 ";
      };
      battery = {
        disabled = true;
      };
      nodejs = {
        disabled = true;
      };
      rust = {
        disabled = true;
      };
      package = {
        disabled = true;
      };
      elixir = {
        disabled = true;
      };
      deno = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = "󰖟 ";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = false;

    antidote = {
      enable = true;
      plugins = [
        "jeffreytse/zsh-vi-mode"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions"
      ];
    };

    # History configuration
    history = {
      path = "$XDG_CONFIG_HOME/zsh/.zsh_history";
      size = 10000;
      save = 10000;
      share = true;
      ignoreSpace = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    initContent = ''
      # Source Nix environment
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      else
        # Fallback: manually add Nix to PATH
        export PATH="$HOME/.nix-profile/bin:$PATH"
      fi

      export GPG_TTY=$(tty)

      # Load Keybinds
      autoload -U select-word-style
      select-word-style bash
      source ${./zsh_keybinds}

      # Completion - cache compinit for faster startup
      autoload -Uz compinit
      setopt extended_glob
      if [[ -n ''${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
        compinit
      else
        compinit -C
      fi

      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
      zstyle ':completion:*' list-colors '''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion::complete:*' gain-privileges 1

      ZSH_HIGHLIGHT_STYLES[comment]='fg=8'

      # Support bash-like completition
      autoload bashcompinit
      bashcompinit

      # Set history stuff
      ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
      HISTFILE=$ZDOTDIR/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt interactivecomments

      # edit the command line in $EDITOR. Not in the keybinds file because it was being
      # overwritten by the plugins
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey '^E' edit-command-line
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      # Source stuff
      source ${./aliases.sh}

      # Lazy-load kubectl completion for faster startup
      kubectl() {
        unfunction kubectl
        source <(command kubectl completion zsh)
        kubectl "$@"
      }

      # Source extra config (secrets, machine-specific settings)
      [ -f $HOME/.extra.zsh ] && source $HOME/.extra.zsh

      # System fetch on startup (skip if in nix dev profile)
      [ -z "$USING_NIX_DEV" ] && f
    '';
  };
}
