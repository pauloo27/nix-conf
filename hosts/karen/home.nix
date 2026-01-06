{ pkgs, f, ... }: {
  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/tmux.nix
    ../../shared/linux.nix
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "karen admin";
        email = "admin@karen.db.cafe";
      };
      core = {
        editor = "nvim --cmd 'let g:unception_block_while_host_edits=1'";
      };
      pull = {
        rebase = false;
      };
      init = {
        defaultBranch = "main";
      };
      rerere = {
        enabled = true;
      };
    };
  };

  home.packages = [ ];

  home.stateVersion = "24.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
