{ ... }:
{
  programs.starship.enableBashIntegration = false;
  programs.zoxide.enableBashIntegration = false;

  programs.bash = {
    enable = true;

    historyFileSize = 10000;
    historySize = 10000;
    historyControl = [ "ignoredups" "ignorespace" ];

    initExtra = ''
      source ${./aliases.sh}
      source ${./kubectl-wrapper.sh}

      # Fedora-style prompt + terminal title (adapted from Fedora's /etc/bashrc)
      shopt -s checkwinsize
      PS1='\[\e[32m\][\u@\h \W]\$\[\e[0m\] '
      case $TERM in
        xterm*)  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "''${USER}" "''${HOSTNAME%%.*}" "''${PWD/#$HOME/\~}"' ;;
        screen*) PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "''${USER}" "''${HOSTNAME%%.*}" "''${PWD/#$HOME/\~}"' ;;
      esac
    '';
  };
}
