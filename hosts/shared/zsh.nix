{ pkgs, ... }: {
  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    EDITOR = "nvim";
    GOPATH = "$HOME/dev/go";
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
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions"
        "jeffreytse/zsh-vi-mode"
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
      export GPG_TTY=$(tty)

      # Enable interactive comments
      setopt interactivecomments

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

      # Enable bash completion compatibility
      autoload bashcompinit
      bashcompinit

      # Plugin configuration
      # zsh-vi-mode: prevent conflicts with fzf
      ZVM_INIT_MODE=sourcing

      # zsh-autosuggestions strategy
      ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

      # zsh-syntax-highlighting: dim comments
      ZSH_HIGHLIGHT_STYLES[comment]='fg=8'

      # Command line editing in $EDITOR (Ctrl+E)
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey '^E' edit-command-line

      # Completion styling
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion::complete:*' gain-privileges 1
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      # Source aliases
      source ${./aliases.sh}
      source ${./zsh_keybinds}

      # System fetch on startup
      f

      # Source extra config (secrets, machine-specific settings)
      [ -f $HOME/.extra.zsh ] && source $HOME/.extra.zsh
    '';
  };
}
