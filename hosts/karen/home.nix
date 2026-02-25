{ pkgs, f, ... }:
{
  imports = [
    # base os stuff
    ../../shared/home/linux.nix

    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/tmux.nix
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
