{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    signing = {
      key = "9C547E6289CF30DB";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Paulo";
        email = "git@pauloo27.dev";
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
      alias = {
        s = "status -s";
        rs = "restore";
        ds = "diff --staged";
        d = "diff";
        unadd = "restore --staged";
      };
    };
  };
}
