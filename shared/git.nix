{ pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "Paulo";
    userEmail = "git@pauloo27.dev";

    signing = {
      key = "9C547E6289CF30DB";
      signByDefault = true;
    };

    extraConfig = {
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
}
