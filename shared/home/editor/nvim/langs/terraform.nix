{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "terraform"
    "hcl"
  ];

  myNvim.conform.formatters_by_ft = {
    terraform = [ "terraform_fmt" ];
  };

  programs.neovim.extraPackages = [ pkgs.terraform-ls ];

  programs.neovim.initLua = builtins.readFile ./terraform.lua;
}
